extends GTState

signal cooldown_ended()

func _on_CooldownTimer_timeout():
	if fsm.current_state == self:
		emit_signal("cooldown_ended")
