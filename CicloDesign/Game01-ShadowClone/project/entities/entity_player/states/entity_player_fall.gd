extends "res://entities/entity_player/states/entity_player_movement_state.gd"

signal touched_ground()

func physics_process(delta):
	.physics_process(delta)
	if actor.body.is_grounded():
		emit_signal("touched_ground")
