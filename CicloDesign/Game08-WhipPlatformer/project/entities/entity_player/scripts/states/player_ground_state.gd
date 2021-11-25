extends "res://entities/entity_player/scripts/states/__player_base_state.gd"

func enter(info: Dictionary = {}):
	if get_move_direction() != 0:
		fsm.change_state("ground/walk")
	else:
		fsm.change_state("ground/idle")
