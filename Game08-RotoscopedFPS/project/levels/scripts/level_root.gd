extends Node

signal checkpoint_reached(point)

const TERRAIN_COLLISION_LAYER = 2
const TERRAIN_COLLISION_MASK = 4
const SAVEABLE_ENTITIES = {
	Globals.ENTITIES.ENEMY_ZOMBIE: preload("res://entities/enemies/enemy_zombie/enemy_zombie.tscn"),
	Globals.ENTITIES.ENEMY_ZOMBIE_CORPSE: preload("res://entities/enemies/enemy_zombie_corpse/enemy_zombie_corpse.tscn")}

onready var map = $map
var entity_count = {}

func _ready():
	for entity in map.get_children():
		if entity is StaticBody:
			entity.collision_layer = TERRAIN_COLLISION_LAYER
			entity.collision_mask = TERRAIN_COLLISION_MASK
