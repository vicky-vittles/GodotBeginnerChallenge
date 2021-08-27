extends "res://entities/__entity_platformer_player/states/entity_player_movement_state.gd"

signal started_jumping()
signal pressed_boost()
signal started_boost()
signal started_falling()

func physics_process(delta):
	.physics_process(delta)
	if actor.entity_mover.velocity.y > 0:
		emit_signal("started_falling")

func damp_jump():
	if fsm.current_state == self:
		actor.entity_mover.damp_jump()

func _on_jump_just_pressed():
	if fsm.current_state == self and actor.entity_mover.can_jump() and actor.jump_cooldown_timer.is_stopped():
		emit_signal("started_jumping")

func _on_boost_just_pressed():
	if fsm.current_state == self and actor.boost_cooldown_timer.is_stopped():
		emit_signal("pressed_boost")
		if actor.boost_trigger.can_boost:
			emit_signal("started_boost")
