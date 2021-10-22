extends GTMenu

signal game_ended()

func game_over():
	emit_signal("game_ended")
