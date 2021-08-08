extends Area

export (NodePath) var actor_path
var actor

func _ready():
	assert(actor_path != null and not actor_path.is_empty())
	actor = get_node(actor_path)
	assert(actor != null)
