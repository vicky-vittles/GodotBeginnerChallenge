extends "res://entities/weapon/__weapon.gd"

const COLLISION_MASK : int = 64

export (bool) var shoot_using_look_direction = false
export (float) var MAX_RANGE = 100

onready var muzzle_flash_timer = $MuzzleFlashTimer

func fire():
	var space_rid = get_world().space
	var space_state = PhysicsServer.space_get_direct_state(space_rid)
	
	var direction = look_direction if shoot_using_look_direction else shoot_direction
	var start_pos = global_transform.origin
	var end_pos = start_pos + direction * MAX_RANGE
	var result = space_state.intersect_ray(start_pos, end_pos, [actor], COLLISION_MASK, false, true)
	
	if result:
		var collider = result.collider
		for group in weapon_excluded_groups:
			if collider.is_in_group(group):
				return
		for group in weapon_collidable_groups:
			if collider.is_in_group(group) and collider.has_method("hurt"):
				collider.hurt(MAX_DAMAGE, result)
				break
