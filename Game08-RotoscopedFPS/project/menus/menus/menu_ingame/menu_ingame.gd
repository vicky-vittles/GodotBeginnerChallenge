extends GTMenu

onready var system_controller = $SystemController

func _process(delta):
	system_controller.poll_input()
