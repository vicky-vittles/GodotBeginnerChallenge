extends GTGravityCharacterMover2D

func move_body(delta):
	body.global_position += velocity * delta
