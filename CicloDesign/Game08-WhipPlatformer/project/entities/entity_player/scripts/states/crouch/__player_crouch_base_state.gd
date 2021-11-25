extends "res://entities/entity_player/scripts/states/__player_base_state.gd"

func get_head_raycasts_colliding():
	for raycast in entity.head_raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false
