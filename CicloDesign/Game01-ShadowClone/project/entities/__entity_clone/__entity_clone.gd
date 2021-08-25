extends GTEntity2D

onready var body = $Body

func update_position(pos: Vector2):
	body.global_position = pos
