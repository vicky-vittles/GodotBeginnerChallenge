extends Node2D
signal projectile_exploded(projectile, explosions)

func add_projectile(proj, map: Array):
	add_child(proj)
	proj.collision_map = map
	proj.connect("exploded", self, "_on_Projectile_exploded")

func _on_Projectile_exploded(proj):
	for explosion in proj.explosions:
		var explosion_node = proj.EXPLOSION.instance()
		add_child(explosion_node)
		explosion_node.global_position = explosion[0]
		explosion_node.init(explosion)
		proj.explosion_nodes.append(explosion_node)
	emit_signal("projectile_exploded", proj, proj.explosions)
