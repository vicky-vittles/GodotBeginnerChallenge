extends "res://entities/entity_player/scripts/states/__player_base_state.gd"

func enter(info: Dictionary = {}):
	entity.entity_mover.set_move_speed(entity.walk_move_speed)
	entity.entity_mover.set_walk_mode(1)
	if get_move_direction() != 0:
		fsm.change_state("ground/walk")
	else:
		fsm.change_state("ground/idle")
