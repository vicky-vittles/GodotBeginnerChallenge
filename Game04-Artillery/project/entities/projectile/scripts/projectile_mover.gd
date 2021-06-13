extends Node

signal has_collided()

export (NodePath) var body_path
onready var body = get_node(body_path)

export (int) var MAX_SPEED = 100
export (float) var GRAVITY = 3.125

export (Vector2) var gravity_direction = Vector2(0, 1)
export (Vector2) var movement_mask = Vector2(1, 1)

var angle : float
var speed : Vector2

var acceleration : Vector2
var velocity : Vector2


func _physics_process(delta):
	move(delta)

func move(delta):
	velocity.y += acceleration.y * gravity_direction.y * delta
	velocity.x = speed.x
	velocity *= movement_mask
	body.global_position += velocity * delta
	if is_colliding():
		emit_signal("has_collided")

# Collision map
func is_colliding() -> bool:
	var candidates = []
	var pos = Vector2(int(body.global_position.x), int(body.global_position.y))
	for y in range(pos.y - body.PIXEL_COLLISION_RADIUS, pos.y + body.PIXEL_COLLISION_RADIUS+1):
		for x in range(pos.x - body.PIXEL_COLLISION_RADIUS, pos.x + body.PIXEL_COLLISION_RADIUS+1):
			if get_map(x, y, body.collision_map):
				return true
	return false

func get_map(x, y, map):
	x = clamp(x, 0, map[0].size()-1)
	y = clamp(y, 0, map.size()-1)
	return map[y][x]


# Setup
func fire(_angle, charge):
	angle = _angle
	speed = Vector2(set_speed_for_projectile(charge), 0).rotated(angle)
	acceleration.y = GRAVITY
	velocity = speed

func set_speed_for_projectile(charge):
	return MAX_SPEED * charge

func set_gravity_for_projectile(_speed, _angle, max_distance):
	return (_speed * _speed * sin(2*_angle)*sin(2*_angle)) / max_distance
