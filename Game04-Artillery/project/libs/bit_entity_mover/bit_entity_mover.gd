extends Node
class_name BitEntityMover

export (NodePath) var body_path
onready var body = get_node(body_path)

export (int) var pixel_gravity = 4
export (bool) var stay_parallel_to_floor = false

func fall():
	var curr_pos = Vector2(body.global_position.x, body.global_position.y)
	var pixel_pos = Vector2(int(curr_pos.x), int(curr_pos.y))
	var next_ground = find_next_ground(pixel_pos.x, pixel_pos.y, body.collision_map)
	
	body.global_position.y = clamp(curr_pos.y + pixel_gravity, 0, next_ground)
	
	if stay_parallel_to_floor:
		var floor_angle = get_local_floor_slope(pixel_pos.x, pixel_pos.y, body.collision_map)
		body.base.rotation_degrees = -floor_angle

func get_map(x, y, map):
	x = clamp(x, 0, map[0].size()-1)
	y = clamp(y, 0, map.size()-1)
	return map[y][x]

func find_next_ground(x: int, my_y: int, map: Array):
	for y in map.size():
		if y >= my_y:
			if get_map(x, y, map):
				return y
	return -1

func get_local_floor_slope(x, y, map) -> float:
	var left = find_next_ground(x-2, y, map)
	var right = find_next_ground(x+2, y, map)
	var angle = atan2(left-right, 4)
	return rad2deg(angle)
