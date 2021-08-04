extends "res://entities/weapon/__weapon.gd"

export (Array, String) var collidable_group
export (bool) var use_look_direction = false
export (float) var MAX_RANGE = 100
export (float) var MAX_DAMAGE = 50

const COLLISION_MASK : int = 8

func fire():
	var space_rid = get_world().space
	var space_state = PhysicsServer.space_get_direct_state(space_rid)
	
	var direction = look_direction if use_look_direction else shoot_direction
	var start_pos = global_transform.origin
	var end_pos = start_pos + direction * MAX_RANGE
	var result = space_state.intersect_ray(start_pos, end_pos, [actor], COLLISION_MASK, false, true)
	
	if result:
		var collider = result.collider
		for group in collidable_group:
			if collider.is_in_group(group) and collider.has_method("hurt"):
				collider.hurt(MAX_DAMAGE)
				break
