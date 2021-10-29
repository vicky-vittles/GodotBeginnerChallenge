extends Node

enum ENTITY_TYPES {
	NULL = 0,
	ENTITY_PLAYER = 1,
	ENTITY_BOMB = 2,
	ENTITY_EXPLOSION = 3,
	ENTITY_SPRITE = 4}

const TILE_SIZE : float = 16.0

func get_game():
	return get_node("/root/Game")

func world_to_tile(pos: Vector2) -> Vector2:
	var x = int(pos.x / TILE_SIZE)
	var y = int(pos.y / TILE_SIZE)
	return Vector2(x, y)

func tile_to_world(pos: Vector2) -> Vector2:
	return TILE_SIZE*Vector2.ONE*pos

func snap_to_tile(pos: Vector2) -> Vector2:
	return tile_to_world(world_to_tile(pos))
