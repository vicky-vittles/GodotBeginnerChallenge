extends GTState

export (bool) var can_move = true

func _on_Brain_updated_move_direction(direction):
	if fsm.current_state != self:
		return
	if can_move:
		entity.entity_mover.set_move_direction(direction)
	else:
		entity.entity_mover.set_move_direction(Vector2.ZERO)
