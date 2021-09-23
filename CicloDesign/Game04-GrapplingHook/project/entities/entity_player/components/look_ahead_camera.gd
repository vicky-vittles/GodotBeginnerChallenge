extends Camera2D

export (float) var min_radius = 150

var mouse_position : Vector2

func _physics_process(delta):
	var mouse = mouse_position - get_viewport_rect().size * 0.5
	if mouse.length() < min_radius:
		position = Vector2(0,0)
	else:
		position = mouse.normalized() * (mouse.length() - min_radius) * 0.5

func _on_MouseController_mouse_position(pos):
	mouse_position = pos
