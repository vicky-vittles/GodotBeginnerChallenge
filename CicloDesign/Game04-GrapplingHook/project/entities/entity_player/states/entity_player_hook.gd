extends "res://entities/__entity_platformer_player/states/__entity_platformer_player_movement_state.gd"

signal fire_just_released()

func _on_fire_just_released():
	emit_signal("fire_just_released")

func _on_Hookshot_collided(info):
	var collision_point = info["position"]
	var direction = actor.body.global_position.direction_to(collision_point)
	actor.entity_mover.disable()
	actor.hook_entity_mover.enable()
	actor.hook_entity_mover.set_move_direction(direction)
	actor.hook_entity_mover.velocity = actor.hook_entity_mover.max_move_speed*direction
