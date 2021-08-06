extends Node

signal checkpoint_reached(point)

const TERRAIN_COLLISION_LAYER = 2
const TERRAIN_COLLISION_MASK = 4
const SAVEABLE_ENTITIES = {
	Globals.ENTITIES.ENEMY_SOLDIER: preload("res://entities/enemies/enemy_soldier/enemy_soldier.tscn"),
	Globals.ENTITIES.ENEMY_SOLDIER_CORPSE: preload("res://entities/enemies/enemy_soldier_corpse/enemy_soldier_corpse.tscn")}

onready var map = $map

func _ready():
	var current_point = 0
	for entity in map.get_children():
		if entity is StaticBody:
			entity.collision_layer = TERRAIN_COLLISION_LAYER
			entity.collision_mask = TERRAIN_COLLISION_MASK
		if entity is Checkpoint:
			current_point += 1
			entity.checkpoint_id = current_point
			entity.connect("checkpoint_reached", self, "_on_Checkpoint_checkpoint_reached")

func save_entities(file_name):
	var entities = []
	for entity in map.get_children():
		if "entity_type" in entity and SAVEABLE_ENTITIES.keys().has(entity.entity_type):
			var entity_info = {
				"position": entity.global_transform.origin,
				"rotation": entity.rotation,
				"type": entity.entity_type}
			entities.append(entity_info)
	return entities

func load_entities(level_info):
	for entity in map.get_children():
		if "entity_type" in entity and SAVEABLE_ENTITIES.keys().has(entity.entity_type):
			entity.queue_free()
	for entity_info in level_info["entities"]:
		if SAVEABLE_ENTITIES.keys().has(entity_info["type"]):
			var new_entity = SAVEABLE_ENTITIES[entity_info["type"]].instance()
			map.add_child(new_entity)
			new_entity.global_transform.origin = entity_info["position"]
			new_entity.rotation = entity_info["rotation"]

func _on_Checkpoint_checkpoint_reached(point):
	emit_signal("checkpoint_reached", point)
