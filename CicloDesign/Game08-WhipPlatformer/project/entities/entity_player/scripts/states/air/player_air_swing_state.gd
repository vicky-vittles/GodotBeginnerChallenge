extends "res://entities/entity_player/scripts/states/air/__player_air_base_state.gd"

var entity_mover : Node
var pendulum_mover : Node

func enter(info: Dictionary = {}):
	entity_mover = entity.entity_mover
	pendulum_mover = entity.pendulum_entity_mover
	
	entity_mover.restore_jumps()
	entity_mover.disable()
	pendulum_mover.enable()
	pendulum_mover.set_info(info["swing_origin"], entity.previous_move_direction)

func exit():
	var swing_center_offset = abs(pendulum_mover.angle-pendulum_mover.ANGLE_OFFSET)/deg2rad(pendulum_mover.starting_angle)
	swing_center_offset = clamp(swing_center_offset, 0.0, 1.0)
	
	#var max_speed = entity.post_swing_move_speed*swing_center_offset
	#entity_mover.velocity.x = max_speed
	
	var max_speed = entity.post_swing_move_speed
	entity_mover.set_move_speed(max_speed)
	entity_mover.enable()
	pendulum_mover.disable()

func physics_process(delta):
	# Movement
	var move_direction = get_move_direction()
	pendulum_mover.set_move_direction(move_direction)
	
	# Transitions
	if get_jump_just_pressed():
		fsm.change_state("air/jump")
