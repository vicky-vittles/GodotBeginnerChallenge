extends GTState

func physics_process(delta):
	var move_direction = actor.input_controller.move_direction
	actor.entity_mover.set_move_direction(move_direction)
	actor.entity_mover.move(delta)
