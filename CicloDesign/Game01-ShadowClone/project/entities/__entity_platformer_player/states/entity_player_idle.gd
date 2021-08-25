extends "res://entities/__entity_platformer_player/states/entity_player_movement_state.gd"

signal started_moving()
signal started_jumping()

func physics_process(delta):
	.physics_process(delta)
	if actor.input_controller.move_direction != 0:
		emit_signal("started_moving")

func _on_jump_just_pressed():
	if fsm.current_state == self:
		emit_signal("started_jumping")
