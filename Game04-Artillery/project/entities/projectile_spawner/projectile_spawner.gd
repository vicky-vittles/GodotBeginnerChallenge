extends Node2D

export (PackedScene) var PROJECTILE

func spawn(angle, charge):
	var projectile = PROJECTILE.instance()
	get_tree().root.get_node("Game").add_projectile(projectile)
	projectile.global_position = global_position
	projectile.init(angle, charge)
