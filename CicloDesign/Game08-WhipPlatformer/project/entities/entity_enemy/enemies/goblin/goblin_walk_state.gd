extends "res://entities/entity_enemy/scripts/states/__enemy_walk_state.gd"

onready var direction_change_timer = $DirectionChangeTimer

func get_move_direction() -> int:
	var left = entity.ground_raycast_left.is_colliding()
	var right = entity.ground_raycast_right.is_colliding()
	if not left and right and direction_change_timer.is_stopped():
		move_direction *= -1
		direction_change_timer.start()
	elif left and not right and direction_change_timer.is_stopped():
		move_direction *= -1
		direction_change_timer.start()
	elif not left and not right:
		move_direction = 0
	return move_direction
