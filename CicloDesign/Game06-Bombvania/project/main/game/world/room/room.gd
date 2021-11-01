extends Node2D

export (int) var camera_limit_left = 0
export (int) var camera_limit_right = 0
export (int) var camera_limit_top = 0
export (int) var camera_limit_bottom = 0

onready var tilemap = $root/Background
onready var bombs = $root/Bombs
onready var explosions = $root/Explosions
onready var entities = $root/Entities

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
