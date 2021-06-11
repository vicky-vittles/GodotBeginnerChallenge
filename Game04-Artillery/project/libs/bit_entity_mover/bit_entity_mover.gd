extends Node
class_name BitEntityMover

export (NodePath) var body_path
onready var body = get_node(body_path)

export (float) var MOVE_SPEED = 30.0
export (bool) var stay_parallel_to_floor

var move_direction : Vector2


func set_move_direction(dir):
	move_direction = dir

func move(delta):
	body.global_position.x += move_direction.x * MOVE_SPEED * delta
	if stay_parallel_to_floor:
		var angle = get_local_floor_slope(int(body.global_position.x), body.collision_map)
		body.rotation = -angle

func fall():
	var ground_current_pos = find_ground(int(body.global_position.x), body.collision_map)
	body.global_position.y = ground_current_pos


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
