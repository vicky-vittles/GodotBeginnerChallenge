extends GTSidescrollerEntityMover2D

enum WALK_MODE {
	USE_MOVE_DIRECTION = 1, # Uses move_direction, limiting it by move_speed
	EXCEED_MOVE_DIRECTION = 2} # Uses the current velocity, damping it until move_speed

export (WALK_MODE) var walk_mode = WALK_MODE.USE_MOVE_DIRECTION

func _movement(delta):
	if frozen or not is_enabled:
		return
	move_direction_press_timer += delta
	
	# Gravity
	if velocity.y < 0:
		velocity.y += jump_gravity * delta
	else:
		velocity.y += fall_gravity * delta
	if velocity.y > max_falling_speed:
		velocity.y = max_falling_speed
	
	# Movement
	var acc_info = get_acceleration_info()
	var dec_info = get_deceleration_info()
	var info = acc_info
	var move_sign = sign(move_direction)
	if move_direction == 0:
		info = dec_info
		move_sign = sign(velocity.x)
	
	var t = clamp(move_direction_press_timer/info["time"], 0.0, 1.0)
	var desired_velocity = move_speed * info["curve"].interpolate_baked(t)
	if walk_mode == WALK_MODE.USE_MOVE_DIRECTION:
		velocity.x = move_sign * desired_velocity
		
	elif walk_mode == WALK_MODE.EXCEED_MOVE_DIRECTION:
		var acc = move_speed/acc_info["time"]
		var dec = move_speed/dec_info["time"]
		if move_direction != 0:
			if abs(velocity.x) > move_speed:
				if move_direction != sign(velocity.x):
					velocity.x += move_direction*acc*delta
			else:
				velocity.x += move_direction*acc*delta
				velocity.x = clamp(velocity.x, -move_speed, move_speed)
		else:
			velocity.x += sign(velocity.x)*dec*delta
			if sign(velocity.x) >= 0:
				velocity.x = clamp(velocity.x, 0, move_speed)
			else:
				velocity.x = clamp(velocity.x, -move_speed, 0)
	
	if velocity.length() < MOVEMENT_THRESHOLD:
		velocity = Vector2.ZERO
	._move(delta)

func set_walk_mode(_mode: int) -> void:
	walk_mode = _mode
