extends Node

signal mouse_position(pos)
signal mouse_from_center(direction)

export (bool) var use_icon = false

var mouse_position : Vector2
var direction_to_center : Vector2

onready var mouse_pos = $CanvasLayer/mouse_pos
onready var mouse_icon = $CanvasLayer/mouse_pos/effects_center/mouse_icon

func _ready():
	mouse_icon.visible = use_icon
	if use_icon:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event is InputEventMouseMotion:
		var pos = event.position
		mouse_position = pos / Globals.get_screen_size()
		direction_to_center = Globals.get_screen_center().direction_to(pos)
		mouse_pos.global_position = pos

func _physics_process(delta):
	emit_signal("mouse_position", mouse_position)
	emit_signal("mouse_from_center", direction_to_center)
