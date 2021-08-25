extends KinematicBody2D

onready var ground_raycasts = $GroundRaycasts

func is_grounded():
	for raycast in ground_raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false
