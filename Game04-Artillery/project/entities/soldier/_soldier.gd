extends Node2D

signal angle_updated(degrees)
signal charge_updated(amount)
signal weapon_shoot(angle, charge, direction)

export (float) var ANGLE_INTERVAL_MIN = -90.0
export (float) var ANGLE_INTERVAL_MAX = 0.0
export (float) var ANGLE_CHANGE_SPEED = 50.0

export (float) var CHARGE_TIME = 3.5

onready var bit_entity_mover = $BitEntityMover
onready var input_controller = $Controller
onready var weapon_selector = $WeaponSelector
onready var base = $Base
onready var graphics = $Base/Graphics
onready var arrow_widget = $Base/Graphics/aim/ArrowWidget
onready var projectile_spawner = $Base/ProjectileSpawner

var charge_amount : float = 0.0
var can_shoot : bool = true

var world
var collision_map = []


func get_angle_amount():
	return arrow_widget.rotation

func get_angle_aim():
	return -input_controller.last_move_direction*rad2deg(get_angle_amount())

func change_aim(aim_direction, delta):
	arrow_widget.rotate(-aim_direction * deg2rad(ANGLE_CHANGE_SPEED) * delta)
	arrow_widget.rotation_degrees = clamp(arrow_widget.rotation_degrees, ANGLE_INTERVAL_MIN, ANGLE_INTERVAL_MAX)
	emit_signal("angle_updated", -1*arrow_widget.rotation_degrees)


func charge_power(is_hold, is_released, delta):
	if not can_shoot:
		return
	if is_hold:
		charge_amount = clamp(charge_amount + delta*(1.0/CHARGE_TIME), 0.0, 1.0)
	if charge_amount > 0.0 and (is_released or charge_amount == 1.0):
		can_shoot = false
		var dir = Vector2(sign(input_controller.last_move_direction), 0)
		dir = dir.rotated(base.rotation)
		dir = dir.rotated(sign(input_controller.last_move_direction)*arrow_widget.rotation)
		var angle_to_shoot = dir.angle()
		#print(rad2deg(angle_to_shoot))
		emit_signal("weapon_shoot", angle_to_shoot, charge_amount, 1)
		charge_amount = 0.0
	emit_signal("charge_updated", charge_amount)


func restore_ammo():
	can_shoot = true
