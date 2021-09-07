extends GTEntity2D

onready var body = $Body

func set_direction(direction):
	body.set_direction(direction)
