
extends Node2D

onready var tilemap = $ysort/tilemap
onready var entities = $ysort/Entities
onready var entities_bombs = $ysort/Entities/Bombs
onready var entities_explosions = $ysort/Entities/Explosions
onready var player = $ysort/Player

func _ready():
	player.world_bombs_manager = entities_bombs

func add_entity(entity):
	if entity.entity_type == Globals.ENTITY_TYPES.ENTITY_BOMB:
		entities_bombs.add_child(entity)
		_configure_bomb(entity)
	elif entity.entity_type == Globals.ENTITY_TYPES.ENTITY_EXPLOSION:
		entities_explosions.add_child(entity)
		_configure_explosion(entity)
	else:
		entities.add_child(entity)

func _configure_bomb(bomb):
	bomb.tilemap = tilemap

func _configure_explosion(explosion):
	tilemap.explosions_to_check.append(explosion)
