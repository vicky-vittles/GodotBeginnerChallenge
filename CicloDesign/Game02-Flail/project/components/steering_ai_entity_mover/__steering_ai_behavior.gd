extends Node
class_name SteeringAIBehavior

export (NodePath) var actor_path
onready var actor = get_node(actor_path)

func _ready():
	assert(actor != null, "%s has no actor set" % [self.name])

func move(delta):
	pass
