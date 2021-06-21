extends Node2D

onready var world = get_parent()

func _ready():
	for player in get_children():
		player.world = world

func get_main_player():
	return get_node("1")

func _on_Level_terrain_updated(map):
	for player in get_children():
		player.collision_map = map
