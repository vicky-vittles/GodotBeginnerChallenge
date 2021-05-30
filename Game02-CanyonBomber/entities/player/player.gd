extends Node2D

signal restore_ammo()
signal spawn_bomb(id, direction)
signal gain_points(points)
signal update_points(total_points)

export (Vector2) var initial_direction
export (int) var player_id = 0
export (int) var bomb_ammo = 1
export (bool) var is_human = false

onready var input_controller = $InputController
onready var entity_mover = $EntityMover
onready var points_manager = $PointsManager
onready var release_bomb_sfx = $SFX/release_bomb_sfx
onready var graphics = $Graphics
onready var effects = $Graphics/Effects

onready var ai_timer = $AITimer
var ai_fire : bool = false

onready var direction = initial_direction
onready var current_ammo = bomb_ammo

func _ready():
	randomize()
	entity_mover.set_direction(direction)
	graphics.set_orientation(initial_direction)
	graphics.set_player_id(player_id)
	if not is_human:
		ai_timer.start()

func _process(delta):
	if is_human:
		input_controller.clear_input()
		input_controller.get_input()
	else:
		if ai_timer.is_stopped():
			var rand_time = 3*randf() + 2
			ai_timer.wait_time = rand_time
			ai_timer.start()

func _physics_process(delta):
	entity_mover.move(delta)
	
	if is_human:
		if current_ammo > 0 and input_controller.bomb_press:
			current_ammo -= 1
			release_bomb_sfx.play()
			emit_signal("spawn_bomb", player_id, Vector2(direction.x, 1))
	else:
		if current_ammo > 0 and ai_fire:
			ai_fire = false
			current_ammo -= 1
			release_bomb_sfx.play()
			emit_signal("spawn_bomb", player_id, Vector2(direction.x, 1))

func plus_points(points):
	emit_signal("gain_points", points)

func update_points(points):
	emit_signal("update_points", points)

func restore_ammo():
	current_ammo = clamp(current_ammo + 1, 0, bomb_ammo)
	emit_signal("restore_ammo")

func _on_AITimer_timeout():
	ai_fire = true
