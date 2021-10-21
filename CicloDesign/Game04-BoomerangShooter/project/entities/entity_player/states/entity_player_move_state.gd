extends "res://entities/entity_player/states/entity_player_base_state.gd"

signal dash_just_pressed()

func _on_dash_just_pressed():
	if fsm.current_state == self:
		emit_signal("dash_just_pressed")
