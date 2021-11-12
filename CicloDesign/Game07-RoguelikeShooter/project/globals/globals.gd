extends Node

enum ENTITY_TYPES {
	NULL = 0,
	ENTITY_PLAYER = 1,
	ENTITY_PROJECTILE = 2}

func get_game():
	return get_node("/root/Game")
