extends GTState

func physics_process(delta):
	actor.entity_mover.set_move_direction(Vector2.ZERO)
	actor.entity_mover.move(delta)
