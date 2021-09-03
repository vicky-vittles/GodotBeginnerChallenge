extends Node2D

signal enemy_died()

func _on_EnemySpawner_entity_spawned(entity):
	entity.connect("died", self, "_on_Enemy_died")

func _on_Enemy_died(enemy):
	emit_signal("enemy_died")
