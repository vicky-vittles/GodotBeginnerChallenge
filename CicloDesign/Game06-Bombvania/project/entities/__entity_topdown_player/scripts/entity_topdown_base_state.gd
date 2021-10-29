extends GTState

signal started_moving()
signal stopped_moving()

export (bool) var can_move = true

func _on_InputController_updated_move_direction(direction):
	if fsm.current_state != self:
		return
	if can_move:
		entity.entity_mover.set_move_direction(direction)
		if direction == Vector2.ZERO:
			emit_signal("stopped_moving")
		else:
			emit_signal("started_moving")
	else:
		entity.entity_mover.set_move_direction(Vector2.ZERO)
