extends Node

signal mouse_position(pos)
signal mouse_from_center(direction)

var mouse_position : Vector2
var direction_to_center : Vector2

func _physics_process(delta):
	mouse_position = get_viewport().get_mouse_position()
	var center = get_viewport().get_visible_rect().size / 2
	direction_to_center = center.direction_to(mouse_position)
	emit_signal("mouse_position", mouse_position)
	emit_signal("mouse_from_center", direction_to_center)
