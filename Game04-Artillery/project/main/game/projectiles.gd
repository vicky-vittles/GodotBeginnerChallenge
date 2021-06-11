extends Node2D
signal projectile_exploded(explosions)

func add_projectile(proj, map: Array):
	add_child(proj)
	proj.collision_map = map
	proj.connect("exploded", self, "_on_Projectile_exploded")

func _on_Projectile_exploded(proj):
	var explosions = []
	for i in proj.MAX_EXPLOSIONS:
		explosions.append([proj.global_position, proj.EXPLOSION_RADIUS])
	emit_signal("projectile_exploded", explosions)
	proj.queue_free()
