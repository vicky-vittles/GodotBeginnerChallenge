extends GTState

signal started_moving(direction)
signal continue_moving()
signal died()

func enter(info = null):
	emit_signal("started_moving", info["direction"])

func _on_KnockbackTimer_timeout():
	if fsm.current_state == self:
		if actor.health.is_alive:
			emit_signal("continue_moving")
		else:
			emit_signal("died")
