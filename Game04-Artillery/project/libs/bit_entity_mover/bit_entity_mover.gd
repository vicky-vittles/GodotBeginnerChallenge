extends Node
class_name BitEntityMover

export (NodePath) var body_path
onready var body = get_node(body_path)

export (float) var move_speed = 30.0
export (int) var pixel_gravity = 4
export (int) var ground_reach = 20
export (float) var linear_gravity = 200.0

export (bool) var stay_parallel_to_floor = false

var move_direction : Vector2
var is_grounded : bool = false
var is_blocked : bool = false

func set_move_direction(dir):
	move_direction = dir

func move(delta):
	var curr_pos = Vector2(body.global_position.x, body.global_position.y)
	var pixel_pos = Vector2(int(curr_pos.x), int(curr_pos.y))
	var walk_x = curr_pos.x + move_direction.x * move_speed * delta
	var fall_y = curr_pos.y
	is_grounded = false
	is_blocked = false
	
	for y in range(-ground_reach, ground_reach+1):
		var dy = fall_y + y
		var above_pos = get_map(int(walk_x), int(dy-1), body.collision_map)
		var ground_pos = get_map(int(walk_x), int(dy), body.collision_map)
		if (not above_pos and ground_pos):
			fall_y = dy
			is_grounded = true
		if (above_pos and ground_pos):
			is_blocked = true
	
	if is_blocked:
		walk_x = curr_pos.x
		fall_y = curr_pos.y
	
	if not is_grounded:
		# Falling
		walk_x = curr_pos.x
		fall_y += pixel_gravity
	
	body.global_position = Vector2(walk_x, fall_y)


func get_map(x, y, map):
	x = clamp(x, 0, map[0].size()-1)
	y = clamp(y, 0, map.size()-1)
	return map[y][x]

func get_local_floor_slope(x, map) -> float:
	var left = find_ground(x-1, map)
	var right = find_ground(x+1, map)
	var angle = atan2(left-right, 2)
	return rad2deg(angle)

func find_ground(x: int, map: Array):
	for y in map.size():
		if get_map(x, y, map):
			return y
	return -1
