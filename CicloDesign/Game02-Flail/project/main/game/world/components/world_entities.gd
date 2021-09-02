extends Node2D

func _on_EnemySpawner_entity_spawned(entity):
	entity.connect("died", self, "_on_Enemy_died")

func _on_Enemy_died(enemy):
	print("morri")
