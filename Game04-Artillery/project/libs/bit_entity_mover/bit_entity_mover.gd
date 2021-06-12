extends Node
class_name BitEntityMover

export (NodePath) var body_path
onready var body = get_node(body_path)

export (float) var MOVE_SPEED = 30.0
export (int) var GROUND_REACH = 25.0
export (bool) var stay_parallel_to_floor = false

var move_direction : Vector2
var linear_gravity : float = 200.0
var is_grounded : bool = true
var can_move : bool = true

func set_move_direction(dir):
	move_direction = dir

func move(delta):
	if is_grounded and can_move:
		body.global_position.x += move_direction.x * MOVE_SPEED * delta
		if stay_parallel_to_floor:
			var angle = get_local_floor_slope(int(body.global_position.x), body.collision_map)
			body.rotation = -angle

func fall(delta):
	var curr_pos = Vector2(int(body.global_position.x), int(body.global_position.y))
	var ground_height = find_ground(curr_pos.x, body.collision_map)
	var ground_local = find_ground_local(curr_pos.x, body.collision_map)
	var d = ground_height - curr_pos.y
	
	if sign(d) >= 0 and d > GROUND_REACH:
		# Falling
		is_grounded = false
		can_move = false
		body.global_position.y += linear_gravity * delta
	elif sign(d) >= 0:
		# Snap to ground
		is_grounded = true
		can_move = true
		body.global_position.y = ground_height
	elif sign(d) < 0 and abs(d) <= GROUND_REACH:
		# Snap above
		is_grounded = true
		can_move = true
		body.global_position.y = ground_height
	elif sign(d) < 0 and abs(d) > GROUND_REACH:
		# Snap to nearest pixel
		if ground_local != -1:
			can_move = true
			body.global_position.y = ground_local


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

func find_ground_local(x: int, map: Array):
	var candidates = []
	for i in range(1,GROUND_REACH*2+1):
		candidates.append(int(pow(-1,i%2) * (ceil(float(i)/2))))
	for y in candidates:
		if get_map(x, y, map):
			return y
	return -1
