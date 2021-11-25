extends "res://entities/entity_player/scripts/states/__player_base_state.gd"

func movement():
	var move_direction = get_move_direction()
	if move_direction != 0:
		entity.entity_mover.set_move_direction(move_direction)
	else:
		entity.entity_mover.set_move_direction(0)
