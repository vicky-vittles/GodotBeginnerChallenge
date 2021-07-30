extends GTConnectedPair2D
class_name GTTeleporter2D

export (bool) var is_indirect = false

func _ready():
	remove_from_group(CONNECTOR_GROUP)
	CONNECTOR_GROUP = "gt_teleporter_2d"
	add_to_group(CONNECTOR_GROUP)
	connect("effect", self, "_on_effect")

func _on_effect(cause, effect, entity):
	if not is_indirect:
		entity.global_position = effect.global_position
	else:
		entity.actor.global_position = effect.global_position
