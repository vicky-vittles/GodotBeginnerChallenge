extends AnimaNode

export (NodePath) var _entity_path

var entity

func _ready():
	entity = get_node(_entity_path)
	assert("Error initializing EntityEnemyAnimations: 'entity' property is null")

