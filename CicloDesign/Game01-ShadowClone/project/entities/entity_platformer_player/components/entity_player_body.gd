extends KinematicBody2D

func is_grounded():
	return is_on_floor()
