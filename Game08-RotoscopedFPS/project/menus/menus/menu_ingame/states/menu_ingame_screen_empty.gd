extends GTState

signal pause_game()

func enter(_info = null):
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false

func exit():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func _on_escape_just_pressed():
	if fsm.current_state == self:
		emit_signal("pause_game")
