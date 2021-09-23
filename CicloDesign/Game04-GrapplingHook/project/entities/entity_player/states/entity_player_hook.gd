extends "res://entities/__entity_platformer_player/states/__entity_platformer_player_movement_state.gd"

signal fire_just_released()

func physics_process(delta):
	actor.body.hook_entity_mover.move(delta)

func _on_fire_just_released():
	emit_signal("fire_just_released")
