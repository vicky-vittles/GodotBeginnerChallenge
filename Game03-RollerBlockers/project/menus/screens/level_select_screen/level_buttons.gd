extends HBoxContainer
signal button_level(level_id)

func _on_LevelButton_pressed(level_id: int):
	emit_signal("button_level", level_id)
