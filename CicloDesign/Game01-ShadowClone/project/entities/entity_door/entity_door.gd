extends GTEntity2D

signal opened()
signal closed()

export (bool) var one_shot = false
var is_open : bool = false

onready var graphics = $Graphics

func open():
	if is_open:
		return
	is_open = true
	graphics.open()
	emit_signal("opened")

func close():
	if not is_open or (is_open and one_shot):
		return
	is_open = false
	graphics.close()
	emit_signal("closed")
