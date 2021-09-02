extends GTArea2D

export (int) var min_speed_for_damage = 1500

func _on_EntityMover_velocity_updated(velocity):
	if velocity.length() < min_speed_for_damage:
		disable_all_shapes()
	else:
		enable_all_shapes()
