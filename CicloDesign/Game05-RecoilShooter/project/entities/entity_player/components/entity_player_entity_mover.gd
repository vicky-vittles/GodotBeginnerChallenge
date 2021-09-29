extends GTTopdownEntityMover2D

export (float) var bounce_factor = 0.8

func _on_collision(result):
	clear_forces()
	velocity = velocity.bounce(result["normal"])*bounce_factor
