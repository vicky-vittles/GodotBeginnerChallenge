extends Node

const TILE_SIZE = 64

const STRENGTH_COLORS = {
	1: Color("ffcd75"),
	2: Color("b13e53"),
	3: Color("5d275d")}

enum ENTITY_TYPES {
	NULL = 0,
	ENTITY_PLAYER = 1,
	ENTITY_PROJECTILE = 2,
	ENTITY_PICKUP = 3,
	ENTITY_ENEMY = 4,
	ENTITY_CAGE = 5}

enum ENEMY_TYPES {
	ENEMY_ZOMBIE = 1}

enum PICKUP_TYPES {
	PLUS_PLAYER_STRENGTH,
	PLUS_PLAYER_SPEED,
	PLUS_PLAYER_HEALTH,
	PLUS_WEAPON_BULLETS,
	PLUS_WEAPON_BULLET_SPEED,
	PLUS_WEAPON_BULLET_SIZE,
	PLUS_WEAPON_BULLET_FIRE_SPEED}

const PLAYER_SPEED_LEVELS = {
	1: 128,
	2: 160,
	3: 192,
	4: 224,
	5: 256,
	6: 288,
	7: 320}
const PLAYER_HEALTH_LEVELS = {
	1: 3,
	2: 4,
	3: 5,
	4: 6,
	5: 7,
	6: 8,
	7: 9}

const ENEMY_STRENGTH_LEVELS = {
	1: Vector2(1,1),
	2: Vector2(1.25, 1.25),
	3: Vector2(1.5, 1.5)}
const ENEMY_HEALTH_LEVELS = {
	1: 5,
	2: 7,
	3: 10}
const ENEMY_MAX_FORCE_LEVELS = {
	1: 56,
	2: 68,
	3: 80}

const BULLET_STRENGTH_LEVELS = {
	1: 1,
	2: 2,
	3: 3,
	4: 4,
	5: 5,
	6: 6,
	7: 7}
const BULLET_SIZE_LEVELS = {
	1: Vector2(1,1),
	2: Vector2(1.125, 1.125),
	3: Vector2(1.25, 1.25),
	4: Vector2(1.375, 1.375),
	5: Vector2(1.5, 1.5),
	6: Vector2(1.625, 1.625),
	7: Vector2(1.75, 1.75)}
const BULLET_SPEED_LEVELS = {
	1: 640,
	2: 704,
	3: 768,
	4: 832,
	5: 896,
	6: 960,
	7: 1024}
const BULLET_FIRE_SPEED_LEVELS = {
	1: 0.5,
	2: 0.4,
	3: 0.3,
	4: 0.2,
	5: 0.1}

func get_game():
	if has_node("/root/Game"):
		return get_node("/root/Game")
	else:
		return get_tree().root.get_child(get_tree().root.get_child_count()-1)
