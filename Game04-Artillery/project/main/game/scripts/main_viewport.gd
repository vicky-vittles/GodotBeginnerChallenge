extends Viewport

onready var multitarget_camera = $MultitargetCamera
onready var look_around_camera = $LookAroundCamera

func _on_Minimap_multitarget_camera():
	multitarget_camera.current = true
	look_around_camera.current = false

func _on_Minimap_look_around_camera(pos, size):
	multitarget_camera.current = false
	look_around_camera.current = true
	look_around_camera.position = pos * (get_visible_rect().size / size)
