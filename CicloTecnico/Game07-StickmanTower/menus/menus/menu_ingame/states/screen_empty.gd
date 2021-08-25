extends GTState

signal game_paused()

func _on_sys_escape_just_pressed():
	if fsm.current_state == self:
		emit_signal("game_paused")
