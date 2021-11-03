extends Node2D

export (Vector2) var room_size = Vector2.ONE
export (Dictionary) var room_triggers = {}

onready var tilemap = $root/Background
onready var bombs = $root/Bombs
onready var explosions = $root/Explosions
onready var entities = $root/Entities
onready var room_triggers_node = $root/RoomTriggers

var camera_limit_left = 0
var camera_limit_right = 0
var camera_limit_top = 0
var camera_limit_bottom = 0

func _ready():
	for trigger in room_triggers_node.get_children():
		trigger.set_destiny_room(get_node(room_triggers[trigger.tag]))
	camera_limit_left = global_position.x
	camera_limit_right = global_position.x + room_size.x*Globals.ROOM_SIZE.x
	camera_limit_top = global_position.y
	camera_limit_bottom = global_position.y + room_size.y*Globals.ROOM_SIZE.y

func unload_room():
	for bomb in bombs.get_children():
		bomb.queue_free()
	for explosion in explosions.get_children():
		explosion.queue_free()
	for entity in entities.get_children():
		entity.queue_free()

func add_entity(entity):
	if entity.entity_type == Globals.ENTITY_TYPES.ENTITY_BOMB:
		bombs.add_child(entity)
		_configure_bomb(entity)
	elif entity.entity_type == Globals.ENTITY_TYPES.ENTITY_EXPLOSION:
		explosions.add_child(entity)
		_configure_explosion(entity)
	else:
		entities.add_child(entity)

func configure_player(player):
	player.room_bombs_manager = bombs

func _configure_bomb(bomb):
	bomb.tilemap = tilemap

func _configure_explosion(explosion):
	tilemap.explosions_to_check.append(explosion)
