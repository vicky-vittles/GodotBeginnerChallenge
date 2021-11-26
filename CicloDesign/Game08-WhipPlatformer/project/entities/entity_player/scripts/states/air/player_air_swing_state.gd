extends "res://entities/entity_player/scripts/states/air/__player_air_base_state.gd"

func enter(info: Dictionary = {}):
	entity.entity_mover.disable()
	entity.pendulum_entity_mover.enable()

func exit():
	entity.entity_mover.enable()
	entity.pendulum_entity_mover.disable()
