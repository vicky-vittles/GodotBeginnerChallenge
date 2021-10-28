extends GTMenu

func _on_screen_game_paused_state_entered():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_screen_game_paused_state_exited():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
