extends GTScreen

signal button_play()
signal button_settings()
signal button_quit()

func _on_play_pressed():
	emit_signal("button_play")

func _on_settings_pressed():
	emit_signal("button_settings")

func _on_quit_pressed():
	emit_signal("button_quit")
