extends GTEntity2D

signal pressed()
signal released()

export (bool) var one_shot = false

var is_pressed : bool = false

func press():
	if is_pressed:
		return
	is_pressed = true
	emit_signal("pressed")

func release():
	if not is_pressed or (is_pressed and one_shot):
		return
	is_pressed = false
	emit_signal("released")
