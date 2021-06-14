extends Viewport

signal multitarget_camera()
signal look_around_camera(pos)

onready var camera_sprite = $Minimap/CanvasLayer/CameraSprite
onready var minimap_size = size

var mouse_pos : Vector2

func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = event.position
		mouse_pos.x = clamp(mouse_pos.x, 0, minimap_size.x)
		mouse_pos.y = clamp(mouse_pos.y, 0, minimap_size.y)

func _process(delta):
	camera_sprite.position = mouse_pos
	
	var mouse_click = Input.is_action_pressed("mouse_click")
	camera_sprite.visible = mouse_click
	if mouse_click:
		emit_signal("look_around_camera", mouse_pos, minimap_size)
	else:
		emit_signal("multitarget_camera")
