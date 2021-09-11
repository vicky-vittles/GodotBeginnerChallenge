extends GTScreen

signal button_play()
signal button_return()

func _on_play_pressed():
	emit_signal("button_play")

func _on_return_pressed():
	emit_signal("button_return")
