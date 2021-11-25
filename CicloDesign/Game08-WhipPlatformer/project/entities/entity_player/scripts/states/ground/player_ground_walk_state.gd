extends "res://entities/entity_player/scripts/states/ground/__player_ground_base_state.gd"

export (float) var grounded_buffer_time = 0.05

var grounded_timer : float = 0.0

func physics_process(delta):
	var move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(move_direction)
	if move_direction == 0:
		fsm.change_state("ground/idle")
	
	grounded_timer -= delta
	if entity.body.is_on_floor():
		grounded_timer = grounded_buffer_time
	
	# Transitions
	if grounded_timer <= 0 and not entity.body.is_on_floor():
		fsm.change_state("air")
	elif get_attack_just_pressed():
		fsm.change_state("ground/attack")
	elif get_jump_just_pressed():
		fsm.change_state("air", {"is_jumping": true})
	elif get_crouch_pressed():
		fsm.change_state("crouch")
