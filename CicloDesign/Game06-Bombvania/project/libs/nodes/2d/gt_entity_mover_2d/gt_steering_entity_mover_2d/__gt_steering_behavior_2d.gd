extends Node
class_name GTSteeringBehavior2D

export (NodePath) var _actor_path
export (bool) var is_enabled = true

var actor : Node

func _ready():
	actor = get_node(_actor_path)
	assert(actor != null, "Error initializing GTSteeringBehavior2D, 'actor' property is null")

func move(delta):
	pass
