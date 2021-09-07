extends "res://entities/__entity_platformer_player/components/entity_platformer_player_body.gd"

signal invert(amplitude, time)
signal tilt(amplitude, time)

func update_tilt(_dir: int = 0):
	var direction = actor.input_controller.move_direction
	emit_signal("tilt", 10.0*direction*entity_mover.gravity_mask, 0.15)

func invert_gravity():
	actor.entity_mover.invert_gravity_mask()
	ground_raycasts.scale.y = entity_mover.gravity_mask
	var final_angle = 180.0 if entity_mover.gravity_mask == -1 else 360.0
	emit_signal("invert", final_angle, 0.2)
