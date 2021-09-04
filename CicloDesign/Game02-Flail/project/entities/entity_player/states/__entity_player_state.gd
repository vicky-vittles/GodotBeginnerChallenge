extends GTState

func physics_process(delta):
	actor.debug_controller.poll_input()
	actor.input_controller.poll_input()
	var move_direction = actor.input_controller.move_direction if actor.input_controller.is_active else actor.debug_controller.move_direction
	actor.entity_mover.set_move_direction(move_direction)
	actor.entity_mover.move(delta)
