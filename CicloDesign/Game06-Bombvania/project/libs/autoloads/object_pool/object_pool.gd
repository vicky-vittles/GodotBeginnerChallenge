extends Node

const ENTITY_EXPLOSION = "entity_explosion"

var active_entities : Dictionary = {
	ENTITY_EXPLOSION: []}
var inactive_entities : Dictionary = {
	ENTITY_EXPLOSION: []}

func _ready():
	for key in active_entities.keys():
		active_entities[key].clear()
	for key in inactive_entities.keys():
		inactive_entities[key].clear()

func add_active_entity(key: String, entity) -> void:
	active_entities[key].append(entity)

func remove_active_entity(key: String, entity) -> void:
	active_entities[key].remove(active_entities[key].find(entity))

func add_inactive_entity(key: String, entity) -> void:
	inactive_entities[key].append(entity)

func pop_inactive_entity(key: String):
	return inactive_entities[key].pop_front()

func has_available_entity(key: String) -> bool:
	return not inactive_entities[key].empty()
