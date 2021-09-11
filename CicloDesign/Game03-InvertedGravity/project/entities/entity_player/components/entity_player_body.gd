extends "res://entities/__entity_platformer_player/components/entity_platformer_player_body.gd"

signal invert(amplitude, time)
signal tilt(amplitude, time)

export (float) var tilt_angle = 10.0
export (float) var tilt_time = 0.15
export (float) var invert_time = 0.2

func update_tilt(_dir: int = 0):
	var direction = actor.input_controller.move_direction
	emit_signal("tilt", tilt_angle*direction*entity_mover.gravity_mask, tilt_time)

func invert_gravity():
	actor.entity_mover.invert_gravity_mask()
	ground_raycasts.scale.y = entity_mover.gravity_mask
	var final_angle = 180.0 if entity_mover.gravity_mask == -1 else 360.0
	emit_signal("invert", final_angle, invert_time)
