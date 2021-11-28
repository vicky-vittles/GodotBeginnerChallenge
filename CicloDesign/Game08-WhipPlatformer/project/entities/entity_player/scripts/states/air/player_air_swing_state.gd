extends "res://entities/entity_player/scripts/states/air/__player_air_base_state.gd"

func enter(info: Dictionary = {}):
	entity.entity_mover.disable()
	entity.pendulum_entity_mover.enable()
	entity.pendulum_entity_mover.set_info(info["swing_origin"], entity.previous_move_direction)

func exit():
	entity.entity_mover.enable()
	entity.pendulum_entity_mover.disable()

func physics_process(delta):
	var move_direction = get_move_direction()
	entity.pendulum_entity_mover.set_move_direction(move_direction)
