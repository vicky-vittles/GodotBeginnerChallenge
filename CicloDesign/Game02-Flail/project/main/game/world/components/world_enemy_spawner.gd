extends "res://components/entity_spawner/entity_spawner.gd"

func apply_info(entity, info):
	entity.targets = info["targets"]
	entity.max_speed = info["max_speed"]
