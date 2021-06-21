extends Node2D

func _on_Level_terrain_updated(map):
	for enemy in get_children():
		enemy.collision_map = map
