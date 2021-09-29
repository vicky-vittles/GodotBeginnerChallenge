extends Node

export (NodePath) var actor_path
onready var actor = get_node(actor_path)
export (PackedScene) var entity_template
export (bool) var add_to_scene = true
export (bool) var is_independent_entity = true

func spawn():
	var info = {
		"position": Vector2.ZERO}
	return spawn_with_info(info)

func spawn_with_pos(pos: Vector2):
	var info = {
		"position": pos}
	return spawn_with_info(info)

func spawn_with_info(info: Dictionary):
	var entity = entity_template.instance()
	if add_to_scene:
		if is_independent_entity:
			Globals.get_game().add_entity(entity)
		else:
			actor.add_child(entity)
	entity.global_position = info["position"]
	return entity
