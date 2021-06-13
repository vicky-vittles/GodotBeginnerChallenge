extends "res://entities/projectile/_projectile.gd"

func effect():
	if global_position.x > 0 and global_position.x < map_limit:
		soldier_owner.global_position = global_position
