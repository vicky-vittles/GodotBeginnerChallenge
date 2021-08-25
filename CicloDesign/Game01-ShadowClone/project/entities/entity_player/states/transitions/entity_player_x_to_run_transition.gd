extends GTStateTransition

func conditions() -> bool:
	return start_state.actor.input_controller.move_direction != 0
