extends "res://libs/menus/screens/_screen.gd"
signal button_level(level_id)
signal button_return()

onready var level_buttons = $vbox/hbox/vbox/buttons/level_buttons

func load_levels():
	for i in range(1, level_buttons.get_child_count()+1):
		if i <= Globals.max_level_reached:
			level_buttons.get_child(i-1).disabled = false
		else:
			level_buttons.get_child(i-1).disabled = true

func _on_LevelButtons_pressed(level_id: int):
	emit_signal("button_level", level_id)
