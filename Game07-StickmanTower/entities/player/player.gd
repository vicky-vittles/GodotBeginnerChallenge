extends KinematicBody2D

onready var input_controller = $InputController
onready var entity_mover = $EntityMover
onready var ground_raycast = $Triggers/GroundRaycast
onready var graphics = $Graphics
onready var jump_cooldown = $Timers/JumpCooldown

var move_direction : int setget ,get_move_direction
var max_jumps : int = 3
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

func is_grounded() -> bool:
	return ground_raycast.is_colliding()