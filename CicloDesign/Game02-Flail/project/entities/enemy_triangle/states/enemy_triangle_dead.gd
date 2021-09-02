extends GTState

signal died()

func enter(_info = null):
	emit_signal("died")
