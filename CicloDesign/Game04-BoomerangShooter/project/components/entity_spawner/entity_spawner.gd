extends Node

signal has_spawned_entity()
signal spawned_entity(entity)

export (NodePath) var actor_path
onready var actor = get_node(actor_path)
export (PackedScene) var entity_template
export (bool) var add_to_scene = true
export (bool) var is_independent_entity = false

func spawn():
	var info = {
		"global_position": Vector2.ZERO}
	return spawn_with_info(info)

func spawn_with_pos(pos: Vector2):
	var info = {
		"global_position": pos}
	return spawn_with_info(info)

func spawn_with_info(info: Dictionary):
	var entity = entity_template.instance()
	if add_to_scene:
		if is_independent_entity:
			Globals.get_game().add_entity(entity)
		else:
			actor.add_child(entity)
	apply_info(entity, info)
	emit_signal("has_spawned_entity")
	emit_signal("spawned_entity", entity)
	return entity

func apply_info(entity, info: Dictionary):
	for key in info.keys():
		if key in entity:
			entity.set(key, info[key])
