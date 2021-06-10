extends Node2D

func _on_Level_terrain_updated(map):
	for player in get_children():
		player.collision_map = map
