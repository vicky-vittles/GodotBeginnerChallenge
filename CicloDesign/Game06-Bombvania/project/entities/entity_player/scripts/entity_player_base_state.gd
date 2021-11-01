extends "res://entities/__entity_topdown_player/scripts/entity_topdown_base_state.gd"

signal bomb_just_pressed()
signal remote_just_pressed()

export (bool) var can_place_bombs = false
export (bool) var can_detonate_bombs = false
export (bool) var can_kick_bombs = false

func physics_process(delta):
	if can_kick_bombs:
		var collision_number = 0
		var push_direction = Vector2.ZERO
		var move_direction = entity.entity_mover.move_direction
		var sign_direction = Vector2(sign(move_direction.x), sign(move_direction.y))
		for raycast in entity.bomb_raycasts.get_children():
			var raycast_direction = raycast.cast_to.normalized()
			if (sign_direction.x != 0 and raycast_direction.x == sign_direction.x) or (sign_direction.y != 0 and raycast_direction.y == sign_direction.y):
				if raycast.is_colliding():
					collision_number += 1
					push_direction = sign_direction
		if collision_number == 1:
			if entity.kick_timer.is_stopped():
				entity.kick_timer.start()
		else:
			entity.kick_timer.stop()

func _on_Player_took_damage(damage):
	if fsm.current_state == self:
		entity.health.lose_health(damage)

func _on_bomb_just_pressed():
	if fsm.current_state == self and can_place_bombs:
		emit_signal("bomb_just_pressed")

func _on_remote_just_pressed():
	if fsm.current_state == self and can_detonate_bombs:
		emit_signal("remote_just_pressed")

func _on_KickTimer_timeout():
	if fsm.current_state == self and can_kick_bombs:
		print("chutou")
