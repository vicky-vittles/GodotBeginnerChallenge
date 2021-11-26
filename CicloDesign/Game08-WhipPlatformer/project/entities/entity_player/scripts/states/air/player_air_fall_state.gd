extends "res://entities/entity_player/scripts/states/air/__player_air_base_state.gd"

export (float) var jump_buffer_time = 0.05
export (bool) var can_move = true

var jump_timer : float = 0.0
var starting_move_direction : int

func enter(info: Dictionary = {}):
	if info.has("starting_move_direction"):
		starting_move_direction = info["starting_move_direction"]
	else:
		starting_move_direction = get_move_direction()
	entity.visuals_animation_player.play("air_fall")

func physics_process(delta):
	# Movement
	var move_direction = starting_move_direction
	if can_move:
		move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(move_direction)
	entity.orient(move_direction)
	
	# Attack
	var attack_just_pressed = get_attack_just_pressed()
	if attack_just_pressed:
		fsm.change_state("air/attack", {"starting_move_direction": starting_move_direction})
	
	# Jump timer
	jump_timer -= delta
	if get_jump_just_pressed():
		jump_timer = jump_buffer_time
	
	# Transitions
	if entity.body.is_on_floor():
		entity.entity_mover.land()
		if jump_timer > 0:
			fsm.change_state("air/jump")
		else:
			fsm.change_state("ground")
