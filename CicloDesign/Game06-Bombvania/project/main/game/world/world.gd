
extends Node2D

onready var tilemap = $tilemap
onready var entities = $Entities
onready var entities_bombs = $Entities/Bombs
onready var entities_explosions = $Entities/Explosions

func add_entity(entity):
	if entity.entity_type == Globals.ENTITY_TYPES.ENTITY_BOMB:
		entities_bombs.add_child(entity)
		entity.tilemap = tilemap
	elif entity.entity_type == Globals.ENTITY_TYPES.ENTITY_EXPLOSION:
		entities_explosions.add_child(entity)
		tilemap.explosions_to_check.append(entity)
	else:
		entities.add_child(entity)
