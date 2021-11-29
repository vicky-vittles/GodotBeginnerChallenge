extends "res://entities/entity_player/scripts/states/__player_base_state.gd"

func enter(info: Dictionary = {}):
	entity.entity_mover.set_move_speed(entity.crouch_move_speed)
	if get_move_direction() != 0:
		fsm.change_state("crouch/walk")
	else:
		fsm.change_state("crouch/idle")
