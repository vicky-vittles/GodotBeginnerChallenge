extends Spatial

const TERRAIN_COLLISION_LAYER = 2
const TERRAIN_COLLISION_MASK = 4

func _ready():
	if has_node("root"):
		var root = get_node("root")
		for entity in root.get_children():
			if entity is StaticBody:
				entity.collision_layer = 2
				entity.collision_mask = 4
