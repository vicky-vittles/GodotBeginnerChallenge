extends GTState

signal started_flying()

func _on_Boomerang_player_fired(direction):
	if fsm.current_state == self:
		actor.move_direction = direction
		emit_signal("started_flying")
