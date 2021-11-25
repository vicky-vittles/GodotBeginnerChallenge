extends "res://entities/entity_player/scripts/states/crouch/__player_crouch_base_state.gd"

func physics_process(delta):
	# Movement
	var move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(0)
	if move_direction != 0:
		fsm.change_state("crouch/walk")
	
	if not entity.body.is_on_floor():
		fsm.change_state("air")
	elif not get_crouch_pressed() and not get_head_raycasts_colliding():
		fsm.change_state("ground")
	elif get_attack_just_pressed():
		fsm.change_state("crouch/attack")
