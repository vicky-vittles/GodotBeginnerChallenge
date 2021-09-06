extends "res://entities/__entity_platformer_player/components/entity_platformer_player_body.gd"

func invert_gravity():
	actor.entity_mover.invert_gravity_mask()
	ground_raycasts.scale.y = entity_mover.gravity_mask
