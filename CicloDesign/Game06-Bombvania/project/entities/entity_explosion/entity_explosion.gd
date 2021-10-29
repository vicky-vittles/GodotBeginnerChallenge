extends GTEntity2D

signal finished(explosion)

onready var graphics = $Body/visuals/graphics

var has_destroyed_tile : bool = false

func destroyed_tile(): has_destroyed_tile = true

func animate():
	graphics.visible = not has_destroyed_tile

func finish():
	emit_signal("finished", self)
