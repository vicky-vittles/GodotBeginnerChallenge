extends GTMenu

signal game_paused()
signal game_resumed()

onready var system_controller = $SystemController

func _process(delta):
	system_controller.poll_input()
