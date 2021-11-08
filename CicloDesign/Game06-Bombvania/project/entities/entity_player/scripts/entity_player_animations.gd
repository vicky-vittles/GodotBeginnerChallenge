extends GTTween

export (NodePath) var _entity_path
export (Curve) var walk_bobbing_start_curve

var entity : Node
var z_height = 0.0

func _ready():
	entity = get_node(_entity_path)
	assert(entity, "Error initializing EntityPlayerAnimations: 'entity' property is null")

func _process(delta):
	entity.main_sprite_position_pivot.position.y = -6*z_height

func walk_bobbing_start():
	remove_all()
	play(self, "z_height", 0.0, 1.0, 0.4, true, walk_bobbing_start_curve)

func walk_bobbing_stop():
	remove_all()
	play(self, "z_height", z_height, 0.0, 0.1)
