extends Node
class_name CorpseSpawner

export (PackedScene) var CORPSE

func spawn_corpse(pos, rotation):
	var corpse = CORPSE.instance()
	Globals.get_game().add_entity(corpse)
	corpse.global_transform.origin = pos
	corpse.rotation = rotation
