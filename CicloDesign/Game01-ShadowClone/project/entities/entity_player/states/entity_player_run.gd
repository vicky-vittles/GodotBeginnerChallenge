extends "res://entities/entity_player/states/entity_player_movement_state.gd"

signal stopped_moving()
signal started_falling()

func physics_process(delta):
	.physics_process(delta)
	if actor.input_controller.move_direction == 0:
		emit_signal("stopped_moving")
	if not actor.body.is_grounded() and actor.coyote_timer.is_stopped():
		emit_signal("started_falling")
