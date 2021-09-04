extends Node2D

signal total_enemies_killed_updated(amount)
signal player_collided()

onready var player = $Player

func _on_TotalEnemiesKilled_points_updated(current):
	emit_signal("total_enemies_killed_updated", current)
	
func _on_Player_collided(collision):
	emit_signal("player_collided", collision)
