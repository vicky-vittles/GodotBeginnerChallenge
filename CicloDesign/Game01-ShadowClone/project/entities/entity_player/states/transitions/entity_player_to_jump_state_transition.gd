extends GTStateTransition

func conditions() -> bool:
	return start_state.actor.entity_mover.can_jump()
