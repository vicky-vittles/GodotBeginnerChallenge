extends "res://entities/__entity_platformer_player/states/entity_player_movement_state.gd"

signal stopped_moving()
signal started_jumping()
signal started_falling()

func physics_process(delta):
	.physics_process(delta)
	if not actor.body.is_grounded() and actor.coyote_timer.is_stopped():
		emit_signal("started_falling")
	elif actor.input_controller.move_direction == 0:
		emit_signal("stopped_moving")

func _on_jump_just_pressed():
	if fsm.current_state == self:
		emit_signal("started_jumping")
