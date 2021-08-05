extends Spatial

onready var projectiles = $projectiles

func add_entity(entity):
	projectiles.add_child(entity)
