extends Spatial

const TERRAIN_COLLISION_LAYER = 2
const TERRAIN_COLLISION_MASK = 4

onready var root = $root

func _ready():
	for entity in root.get_children():
		if entity is StaticBody:
			entity.collision_layer = 2
			entity.collision_mask = 4
