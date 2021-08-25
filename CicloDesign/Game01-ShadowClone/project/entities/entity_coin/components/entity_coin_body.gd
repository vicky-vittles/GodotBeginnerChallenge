extends GTTriggerArea2D

func disable_all_shapes():
	for child in get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", true)
