extends GTMenu

signal game_paused()
signal game_resumed()

onready var system_controller = $SystemController

func _process(delta):
	system_controller.poll_input()

func _on_world_player_died():
	system_controller.is_active = false
