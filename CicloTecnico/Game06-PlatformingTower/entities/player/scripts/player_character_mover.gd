extends GTGravityCharacterMover2D

func move_body(delta):
	velocity = body.move_and_slide(velocity, floor_normal)
