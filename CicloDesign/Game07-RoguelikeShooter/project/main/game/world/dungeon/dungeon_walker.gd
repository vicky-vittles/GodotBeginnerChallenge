extends Node
class_name WalkerAlgorithm

var position : Vector2 = Vector2.ZERO
var direction : Vector2 = Vector2.RIGHT
var borders : Rect2
var step_history = []
var steps_since_turn = 0

var tile_size : Vector2
var directions_lookup : Dictionary
var change_direction_chance : float
var min_steps_since_turn : int
var max_steps_since_turn : int
var min_room_size : int
var max_room_size : int
var rooms = []

func _init(starting_position: Vector2, new_borders: Rect2, _directions: Dictionary, _min_steps: int = 4, _max_steps: int = 8, _chance: float = 0.25, _min_room_size: int = 2, _max_room_size: int = 5, _tile_size: Vector2 = Vector2.ONE):
	assert(new_borders.has_point(starting_position))
	position = starting_position
	step_history.append(position)
	borders = new_borders
	change_direction_chance = _chance
	min_steps_since_turn = _min_steps
	max_steps_since_turn = _max_steps
	min_room_size = _min_room_size
	max_room_size = _max_room_size
	tile_size = _tile_size
	directions_lookup = _directions

func walk(steps):
	place_room(position)
	for step in steps:
		if (steps_since_turn >= min_steps_since_turn) and (randf() <= change_direction_chance or steps_since_turn >= max_steps_since_turn):
			change_direction()
		if step():
			step_history.append(position)
		else:
			change_direction()
	return step_history

func step():
	var target_position = position + direction*tile_size
	if borders.has_point(target_position):
		steps_since_turn += 1
		position = target_position
		return true
	else:
		return false

func change_direction():
	place_room(position)
	steps_since_turn = 0
	var directions = directions_lookup.duplicate()
	directions.erase(direction)
	var bag = RNGTools.WeightedBag.new()
	bag.set_weights(directions)
	choose_direction(bag)
	while not borders.has_point(position + direction*tile_size):
		choose_direction(bag)

func choose_direction(bag):
	var directions = bag.weights.duplicate()
	direction = RNGTools.pick_weighted(bag)
	directions.erase(direction)
	bag.set_weights(directions)

func create_room(pos, _size):
	return Rect2(pos, _size)

func place_room(pos):
	var rand_x = randi()%(max_room_size-min_room_size+1)+min_room_size
	var rand_y = randi()%(max_room_size-min_room_size+1)+min_room_size
	var size = Vector2(rand_x, rand_y)
	var top_left_corner = (position-size/2).ceil()
	rooms.append(create_room(top_left_corner, size))
	for y in size.y:
		for x in size.x:
			var new_step = top_left_corner + Vector2(x,y)
			if borders.has_point(new_step):
				step_history.append(new_step)
