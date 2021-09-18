extends "res://components/ui/ui_popup/ui_popup.gd"

signal response_yes()
signal response_no()

func _on_yes_collect():
	hide()
	emit_signal("response_yes")

func _on_no_collect():
	hide()
	emit_signal("response_no")
