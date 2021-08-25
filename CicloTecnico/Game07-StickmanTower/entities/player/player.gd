extends KinematicBody2D

onready var input_controller = $InputController
onready var entity_mover = $EntityMover
onready var graphics = $Graphics
onready var jump_cooldown = $Timers/JumpCooldown
onready var freeze_timer = $Timers/FreezeTimer

var move_direction : int setget ,get_move_direction
export (int) var max_jumps = 3
onready var available_jumps : int = max_jumps

func get_move_direction() -> int:
	var right = int(input_controller.get_input("act_move_right", input_controller.PRESSED))
	var left = int(input_controller.get_input("act_move_left", input_controller.PRESSED))
	return right - left

func decrease_jump():
	available_jumps = clamp(available_jumps - 1, 0, max_jumps)

func restore_jumps():
	available_jumps = max_jumps

func can_jump() -> bool:
	return (available_jumps > 0 and jump_cooldown.is_stopped())

func _on_game_floor_updated(new_floor):
	freeze_timer.start()
	entity_mover.freeze(false)
