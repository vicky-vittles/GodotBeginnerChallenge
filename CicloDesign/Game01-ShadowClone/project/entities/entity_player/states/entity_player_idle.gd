extends "res://entities/entity_player/states/entity_player_movement_state.gd"

signal started_moving()

func physics_process(delta):
	.physics_process(delta)
	if actor.input_controller.move_direction != 0:
		emit_signal("started_moving")
