extends "res://components/entity_spawner/entity_spawner.gd"

signal has_created_entity()
signal created_entity(entity)

#export (int) var starting_entities = 20

func _ready():
	var test_entity = _entity_template.instance()
	assert(test_entity.has_method("reset_object_pool"), "Error initializing ObjectPoolEntitySpawnerComponent: entity defined in 'entity_template' does not contain a 'reset_object_pool' method")
	assert(test_entity.has_signal("inactive"), "Error initializing ObjectPoolEntitySpawnerComponent: entity defined in 'entity_template' does not contain the 'inactive' signal")

func _process(delta):
	var key = ObjectPool.ENTITY_EXPLOSION
	print(ObjectPool.active_entities[key].size())
	print(ObjectPool.inactive_entities[key].size())
	print("")

func spawn_with_info(info: Dictionary):
	var entity
	var key = ObjectPool.ENTITY_EXPLOSION
	var _created_entity : bool = false
	
	if ObjectPool.has_available_entity(key):
		entity = ObjectPool.pop_inactive_entity(key)
	else:
		entity = _entity_template.instance()
		_created_entity = true
	ObjectPool.add_active_entity(key, entity)
	_put_entity_in_scene(entity)
	_apply_info(entity, info)
	_spawn_signals(entity)
	if _created_entity:
		emit_signal("has_created_entity")
		emit_signal("created_entity", entity)
	else:
		entity.reset_object_pool()
	if not entity.is_connected("inactive", self, "_on_Entity_inactive"):
		entity.connect("inactive", self, "_on_Entity_inactive")
	return entity

func _on_Entity_inactive(entity):
	var key = ObjectPool.ENTITY_EXPLOSION
	entity.get_parent().remove_child(entity)
	ObjectPool.remove_active_entity(key, entity)
	ObjectPool.add_inactive_entity(key, entity)
