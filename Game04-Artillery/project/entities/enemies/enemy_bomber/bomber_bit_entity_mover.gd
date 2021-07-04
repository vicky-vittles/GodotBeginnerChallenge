extends BitEntityMover

func move(move_x, map):
	var curr_pos = Vector2(body.global_position.x, body.global_position.y)
	var pixel_pos = Vector2(int(curr_pos.x), int(curr_pos.y))
	var next_ground = find_ground(pixel_pos.x + move_x, body.collision_map)
	
	var new_pos = body.global_position
	new_pos.x += move_x
	new_pos.y = next_ground
	return new_pos

func find_ground(x: int, map: Array):
	for y in map.size():
		if get_map(x, y, map):
			return y
	return -1
