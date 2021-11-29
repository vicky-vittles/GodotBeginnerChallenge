extends "res://entities/entity_player/scripts/states/air/__player_air_base_state.gd"

var impulse_direction : Vector2

func enter(info: Dictionary = {}):
	if info.has("impulse_direction"):
		impulse_direction = info["impulse_direction"]
