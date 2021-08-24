extends "res://entities/weapon/__weapon.gd"

export (PackedScene) var BULLET

func fire():
	var bullet = BULLET.instance()
	Globals.get_game().add_entity(bullet)
	for group in bullet_groups:
		bullet.add_to_group(group)
	bullet.set_groups(bullet_collidable_groups, bullet_excluded_groups)
	bullet.global_transform.origin = global_transform.origin
	bullet.shoot(shoot_direction, MAX_DAMAGE)
