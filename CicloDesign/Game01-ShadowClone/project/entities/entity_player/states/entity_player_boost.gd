extends "res://entities/__entity_platformer_player/states/entity_player_movement_state.gd"

signal started_falling()

var boost_impulse : Vector2

func enter(_info = null):
	var direction_to_clone = actor.body.global_position.direction_to(actor.boost_trigger.clone_entity.global_position)
	direction_to_clone.y = abs(direction_to_clone.y)
	boost_impulse = actor.boost_speed * -direction_to_clone * actor.boost_direction_mask
	actor.entity_mover.set_impulse(boost_impulse, actor.boost_max_time)

func physics_process(delta):
	.physics_process(delta)
	if actor.entity_mover.velocity.y > 0:
		emit_signal("started_falling")
