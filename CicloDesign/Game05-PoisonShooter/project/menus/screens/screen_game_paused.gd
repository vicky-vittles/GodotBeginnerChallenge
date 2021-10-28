extends GTScreen

signal button_resume()
signal button_settings()
signal button_quit()

func _on_resume_pressed():
	emit_signal("button_resume")

func _on_settings_pressed():
	emit_signal("button_settings")

func _on_quit_pressed():
	emit_signal("button_quit")
