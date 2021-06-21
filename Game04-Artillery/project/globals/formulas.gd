extends Node

const PROJECTILE_MAX_SPEED = 1000
const PROJECTILE_GRAVITY = 351.56

static func calculate_speed(charge: float) -> float:
	return PROJECTILE_MAX_SPEED * charge

static func calculate_gravity(speed, angle, max_distance):
	return (speed*speed * sin(2*angle)*sin(2*angle)) / max_distance
