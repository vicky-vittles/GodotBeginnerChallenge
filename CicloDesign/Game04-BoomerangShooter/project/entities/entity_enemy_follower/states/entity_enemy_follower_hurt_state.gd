extends GTState

signal has_collided()

func _on_EntityMover_collided(result):
	if fsm.current_state == self:
		var angle = result["normal"].angle()
		#actor.particle_collision_rotation_pivot.rotation = angle
		emit_signal("has_collided")
