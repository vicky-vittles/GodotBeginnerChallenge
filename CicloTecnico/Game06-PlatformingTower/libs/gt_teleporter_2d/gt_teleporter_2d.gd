extends Area2D
class_name GTTeleporter2D

signal teleported_entity(entity)

const T_GROUP : String = "gt_teleporter_2d"

export (bool) var is_enter = true
export (String) var teleporter_id = "default"
export (String) var collidable_group = "player"

func _ready():
	add_to_group(T_GROUP)
	connect("area_entered", self, "_on_area_entered")
	connect("body_entered", self, "_on_body_entered")

func teleport(t_id, entity):
	if teleporter_id == t_id and not is_enter:
		entity.global_position = global_position
		emit_signal("teleported_entity", entity)

func _on_area_entered(area):
	if is_enter and area.is_in_group(collidable_group):
		get_tree().call_group(T_GROUP, "teleport", teleporter_id, area)

func _on_body_entered(body):
	if is_enter and body.is_in_group(collidable_group):
		get_tree().call_group(T_GROUP, "teleport", teleporter_id, body)
