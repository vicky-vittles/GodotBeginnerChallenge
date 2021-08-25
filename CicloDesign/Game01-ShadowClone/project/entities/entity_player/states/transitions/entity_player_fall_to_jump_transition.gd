extends GTStateTransition

func conditions() -> bool:
	return start_state.fsm.actor.entity_mover.can_jump() and start_state.fsm.actor.can_jump_while_falling
