extends RigidBody2D

export (float) var FORCE = 1000

func _on_WaveTrigger_grouped_area_entered(area):
	var direction = area.global_position.direction_to(global_position)
	direction = Vector2(direction.x/2.0, -1.0)
	apply_central_impulse(FORCE*direction)
