extends "res://entities/soldier/_soldier.gd"

func get_controller_info():
	return {
		"current_angle": get_angle_amount(),
		"current_charge": charge_amount}

# Important
func calculate_trajectory(my_pos: Vector2, target_pos: Vector2, angle: float, gravity: float):
	var T = target_pos.y-gravity*sin(angle)-my_pos.y
	T *= 2/gravity
	T = sqrt(T)
	print(T)

func is_sight_colliding_with_terrain() -> bool:
	var my_pos = Globals.get_int_pos(projectile_spawner.global_position)
	
	var angle = get_angle_aim()
	var offset = weapon_selector.prototype.EXPLOSION_RADIUS * Vector2(cos(angle), -sin(angle))
	var target_pos = Globals.get_int_pos(my_pos + offset)
	
	var points = get_pixels_between_points(my_pos, target_pos)
	for point in points:
		if get_map(point.x, point.y, collision_map):
			return true
	return false

func get_pixels_between_points(p1: Vector2, p2: Vector2):
	var points = [];
	var N = p1.distance_to(p2);
	for step in N+1:
		var t = 0.0 if N == 0 else (step / N)
		points.append(Globals.get_int_pos(lerp(p1, p2, t)))
	return points;

# Helper functions
func get_map(x: int, y: int, map: Array):
	x = clamp(x, 0, map[0].size()-1)
	y = clamp(y, 0, map.size()-1)
	return map[y][x]
