extends Node

enum ENTITY_TYPES {
	NULL = 0,
	ENTITY_PLAYER = 1,
	ENTITY_BOMB = 2,
	ENTITY_ENEMY = 7,
	ENTITY_EXPLOSION = 3,
	ENTITY_SPRITE = 4,
	ENTITY_COLLECTIBLE = 5,
	ENTITY_PICKUP = 6}

enum ENEMY_TYPES {
	BLOB = 1,
	KNIGHT = 2}

enum PICKUP_TYPES {
	PLUS_AMMO = 1,
	PLUS_FIRE = 2,
	SPIKE_BOMB = 3,
	REMOTE_BOMB = 4}

enum COLLECTIBLE_TYPES {
	HEART = 1,
	MONEY_COIN = 2,
	MONEY_DIAMOND = 3}

enum SPRITE_TYPES {
	ROCK_ANIMATED = 1}

const TILE_SIZE : float = 16.0
const MONEY_COIN : int = 1
const MONEY_DIAMOND : int = 3

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
