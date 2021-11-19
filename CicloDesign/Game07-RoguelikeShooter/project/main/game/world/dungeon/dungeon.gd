extends Node2D

signal reached_end()

export (Resource) var dungeon_resource

onready var tilemap = $tilemap
onready var end_trigger = $EndTrigger
onready var cage_spawner = $CageSpawner

var player
var teleporter_pos

func generate_dungeon():
	assert(dungeon_resource, "Error initializing Dungeon: 'dungeon_resource' is null")
	assert(dungeon_resource is DungeonResource, "Error initializing Dungeon: 'dungeon_resource' is not of type DungeonResource")
	var center_pos = dungeon_resource.dungeon_size/2
	var border = Rect2(Vector2.ZERO, dungeon_resource.dungeon_size)
	var walker = WalkerAlgorithm.new(
		center_pos,
		border,
		dungeon_resource.directions_lookup,
		dungeon_resource.min_steps_since_turn,
		dungeon_resource.max_steps_since_turn,
		dungeon_resource.change_direction_chance,
		dungeon_resource.min_room_size,
		dungeon_resource.max_room_size)
	var steps_history = walker.walk(
		dungeon_resource.steps_taken)
	var rooms = walker.rooms
	draw_dungeon(steps_history)
	place_objects(steps_history, rooms)
	return steps_history

func draw_dungeon(steps_history):
	for step in steps_history:
		tilemap.set_cellv(step, 1)

func place_objects(steps_history, rooms: Array):
	remove_redundant_rooms(rooms)
	var starting_room = define_starting_room(steps_history, rooms)
	place_cages(rooms.duplicate())

func remove_redundant_rooms(rooms: Array):
	rooms.sort_custom(Utils, "sort_by_size")
	rooms.invert()
	var rooms_allowed = {}
	for room in rooms:
		rooms_allowed[room] = true
	for room_m in rooms:
		for room_k in rooms:
			if room_m == room_k:
				continue
			if room_m.intersects(room_k, true) and rooms_allowed[room_m]:
				rooms_allowed[room_k] = false
	for room in rooms_allowed.keys():
		if not rooms_allowed[room]:
			rooms.remove(rooms.find(room))

func define_starting_room(steps_history, rooms: Array):
	for room in rooms:
		if room.has_point(steps_history[0]):
			return room
	return null

func place_cages(rooms):
	for i in dungeon_resource.number_of_cages:
		var rand_index = randi() % rooms.size()
		var rand_room = rooms[rand_index]
		rooms.remove(rand_index)
		var cage_pos = (rand_room.position*Globals.TILE_SIZE) + (rand_room.size*Globals.TILE_SIZE/2)
		var cage = cage_spawner.spawn_with_pos(cage_pos)
		var bag = RNGTools.WeightedBag.new()
		bag.set_weights(dungeon_resource.enemy_strength_weights)
		var rand_strength = RNGTools.pick_weighted(bag)
		cage.strength = rand_strength
		cage.player = player

func _on_EndTrigger_effect():
	emit_signal("reached_end")
