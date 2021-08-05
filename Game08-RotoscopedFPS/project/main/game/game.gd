extends Spatial

onready var world = $World

func add_entity(entity):
	world.add_entity(entity)
