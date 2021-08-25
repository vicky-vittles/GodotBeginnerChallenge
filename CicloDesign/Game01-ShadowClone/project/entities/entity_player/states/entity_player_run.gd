extends GTState

func process(delta):
	actor.input_controller.poll_input()

func physics_process(delta):
	actor.entity_mover.set_move_direction(actor.input_controller.move_direction)
	actor.entity_mover.move(delta)
