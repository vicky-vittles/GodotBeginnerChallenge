extends GTState

func process(delta):
	actor.input_controller.poll_input()

func physics_process(delta):
	actor.entity_mover.set_move_direction(0)
	actor.entity_mover.move(delta)
