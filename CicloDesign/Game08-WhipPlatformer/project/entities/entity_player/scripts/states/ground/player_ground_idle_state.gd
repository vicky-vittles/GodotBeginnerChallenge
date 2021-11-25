extends "res://entities/entity_player/scripts/states/ground/__player_ground_base_state.gd"

func physics_process(delta):
	# Movement
	var move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(0)
	if move_direction != 0:
		fsm.change_state("ground/walk")
	
	# Transitions
	if not entity.body.is_on_floor():
		fsm.change_state("air")
	elif get_attack_just_pressed():
		fsm.change_state("ground/attack")
	elif get_jump_just_pressed():
		fsm.change_state("air", {"is_jumping": true})
	elif get_crouch_pressed():
		fsm.change_state("crouch")
