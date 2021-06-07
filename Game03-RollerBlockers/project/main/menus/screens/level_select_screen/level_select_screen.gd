extends "res://main/menus/screens/_screen.gd"
signal button_level(level_id)
signal button_return()

func _on_LevelButtons_pressed(level_id: int):
	emit_signal("button_level", level_id)
