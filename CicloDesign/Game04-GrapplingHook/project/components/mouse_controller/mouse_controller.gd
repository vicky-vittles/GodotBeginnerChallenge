extends Node

signal mouse_position(pos)
signal mouse_from_center(direction)

var mouse_position : Vector2
var direction_to_center : Vector2

onready var mouse_icon = $CanvasLayer/mouse_icon

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event is InputEventMouseMotion:
		mouse_position = event.position
		var center = get_viewport().get_visible_rect().size / 2
		direction_to_center = center.direction_to(mouse_position)
		mouse_icon.global_position = mouse_position
		emit_signal("mouse_position", mouse_position)
		emit_signal("mouse_from_center", direction_to_center)
