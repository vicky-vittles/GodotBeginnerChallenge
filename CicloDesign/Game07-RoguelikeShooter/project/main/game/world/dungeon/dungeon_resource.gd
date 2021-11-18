extends Resource
class_name DungeonResource

export (Vector2) var dungeon_size = Vector2(15, 8)
export (float) var steps_taken = 1000
export (Dictionary) var directions_lookup = {
	Vector2.RIGHT: 25,
	Vector2.UP: 25,
	Vector2.LEFT: 25,
	Vector2.DOWN: 25}
export (int) var min_steps_since_turn = 4
export (int) var max_steps_since_turn = 8
export (float) var change_direction_chance = 0.25
export (int) var min_room_size = 5
export (int) var max_room_size = 10

export (int) var number_of_cages = 2
export (Dictionary) var enemy_strength_weights = {
	1: 1,
	2: 0,
	3: 0}
