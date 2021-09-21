extends KinematicBody2D

export (NodePath) var actor_path
onready var actor = get_node(actor_path)

onready var ground_raycasts = $GroundRaycasts
onready var entity_mover = $EntityMover

func is_grounded():
	for raycast in ground_raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false
