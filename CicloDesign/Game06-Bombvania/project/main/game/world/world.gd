extends Node2D

export (NodePath) var _initial_room

onready var rooms = $Rooms.get_children()
onready var player = $Player
onready var camera = $Camera

var is_switching : bool = false
var room_to_switch
var current_room

func _ready():
	var initial_room = get_node(_initial_room)
	assert(initial_room, "Error initializing World: 'initial_room' property is null")
	camera.add_target(player.body)
	_on_Rooms_switched_room(initial_room)

func _process(delta):
	if not is_switching: return
	switch_rooms(room_to_switch)
	unload_rooms()
	room_to_switch = null
	is_switching = false

func switch_rooms(new_room):
	current_room = new_room
	if not current_room.is_inside_tree():
		$Rooms.add_child(current_room)
	current_room.configure_player(player)
	camera.limit_left = current_room.camera_limit_left
	camera.limit_right = current_room.camera_limit_right
	camera.limit_top = current_room.camera_limit_top
	camera.limit_bottom = current_room.camera_limit_bottom

func unload_rooms():
	for room in rooms:
		if room.is_inside_tree() and room != current_room:
			room.get_parent().remove_child(room)

func add_entity(entity):
	current_room.add_entity(entity)

func _on_Rooms_switched_room(new_room):
	room_to_switch = new_room
	is_switching = true
