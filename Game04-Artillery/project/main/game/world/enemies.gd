extends Node2D

var collision_map = []

func _on_Level_terrain_updated(map):
	collision_map = map

func _physics_process(_delta):
	for enemy in get_children():
		enemy.collision_map = collision_map

func _on_World_player_died():
	for enemy in get_children():
		enemy.grace_timer.stop()
		enemy.can_move = false
