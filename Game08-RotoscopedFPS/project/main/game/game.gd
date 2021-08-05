extends Spatial

onready var projectiles = $projectiles

func add_entity(entity):
	projectiles.add_child(entity)


func _on_Player_died():
	print("morri")
