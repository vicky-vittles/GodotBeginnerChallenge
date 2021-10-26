extends Node2D

export (int) var explosion_radius = 16

onready var explosion_node = $explosion

func explosion():
	for child in explosion_node.get_children():
		var pos_x = child.global_position.x
		var pos_y = child.global_position.y
		var rand_pos = GTRandomPointZone2D.random_point_circle(pos_x, pos_y, explosion_radius)
		child.global_position = rand_pos
