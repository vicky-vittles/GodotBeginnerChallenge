extends Node
class_name GTEntityMover3D

signal jumped()
signal movement_info(velocity, grounded)

export (NodePath) var body_path
onready var body = get_node(body_path)

export (float) var MAX_RUN_SPEED = 16
export (float) var RUN_ACCELERATION = 20
export (float) var RUN_DECELERATION = 5
export (float) var JUMP_HEIGHT = 3
export (float) var JUMP_TIME = 0.35
export (float, 0.0, 1.0) var JUMP_DAMPING = 0.3

export (Vector3) var movement_mask = Vector3(1, 1, 1)
export (Vector3) var floor_normal = Vector3.UP
export (bool) var apply_gravity = true
export (bool) var frozen = false
export (bool) var is_relative = true
export (bool) var stop_on_slopes = false
export (float) var floor_max_angle = 45

onready var JUMP_SPEED = -Utils.jump_speed_formula(JUMP_HEIGHT, JUMP_TIME)
onready var GRAVITY = Utils.gravity_formula(JUMP_HEIGHT, JUMP_TIME)

var move_direction : Vector2
var velocity : Vector3
var acceleration
var snap : Vector3 = Vector3.DOWN

func _ready():
	assert(body != null, "%s has no body set" % [self.name])

func set_move_direction(_dir: Vector2):
	move_direction = _dir

func move(delta):
	if frozen:
		return
	var current_move_direction = Vector3(move_direction.x, 0, move_direction.y)
	if is_relative:
		current_move_direction = current_move_direction.rotated(Vector3.UP, body.rotation.y)
	
	var ground_velocity = velocity * Vector3(1, 0, 1)
	var desired_velocity = MAX_RUN_SPEED * current_move_direction
	acceleration = RUN_DECELERATION
	if current_move_direction.dot(ground_velocity) > 0:
		acceleration = RUN_ACCELERATION
	ground_velocity = ground_velocity.linear_interpolate(desired_velocity, acceleration * delta)
	
	velocity.x = ground_velocity.x
	velocity.z = ground_velocity.z
	if apply_gravity:
		velocity.y += -GRAVITY * delta
	velocity *= movement_mask
	velocity = body.move_and_slide_with_snap(velocity, snap, floor_normal, stop_on_slopes, 4, deg2rad(floor_max_angle))
	emit_signal("movement_info", velocity, is_grounded())

func jump() -> void:
	velocity.y = JUMP_SPEED * movement_mask.y
	emit_signal("jumped")

func damp_jump() -> void:
	velocity.y *= JUMP_DAMPING

func is_grounded() -> bool:
	return body.is_on_floor()

func freeze(preserve_momentum: bool = true):
	if not preserve_momentum:
		velocity = Vector3.ZERO
	frozen = true

func unfreeze():
	frozen = false

func turn_on_snap():
	snap = Vector3.DOWN

func turn_off_snap():
	snap = Vector3.ZERO
