extends GTState

export (bool) var can_poll_input = true

func process(delta):
	actor.input_controller.clear_input()
	if can_poll_input:
		actor.input_controller.poll_input()

func physics_process(delta):
	var move_direction = actor.input_controller.move_direction
	actor.entity_mover.set_move_direction(move_direction)
	actor.entity_mover.move(delta)
