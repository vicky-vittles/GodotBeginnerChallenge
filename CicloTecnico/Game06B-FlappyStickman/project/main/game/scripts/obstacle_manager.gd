extends Node2D

signal point_gained(point)

const DOUBLE_PIPE = preload("res://entities/pipe/double_pipe.tscn")

export (int) var MIN_OBSTACLE_HEIGHT = 360
export (int) var MAX_OBSTACLE_HEIGHT = 640

func stop_pipes():
	for child in get_children():
		child.stop_pipe()

func spawn():
	var double_pipe = DOUBLE_PIPE.instance()
	add_child(double_pipe)

	double_pipe.global_position.x = 1440
	double_pipe.global_position.y = randf()*(MAX_OBSTACLE_HEIGHT-MIN_OBSTACLE_HEIGHT) + MIN_OBSTACLE_HEIGHT
