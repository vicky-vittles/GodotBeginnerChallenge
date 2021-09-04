extends Node2D

signal player_died()
signal enemy_died()
signal total_enemies_killed_updated(amount)
signal player_collided()

onready var player = $Player

func _on_Player_died():
	emit_signal("player_died")

func _on_Entities_enemy_died():
	emit_signal("enemy_died")

func _on_TotalEnemiesKilled_points_updated(current):
	Globals.current_score = current
	emit_signal("total_enemies_killed_updated", current)
	
func _on_Player_collided(collision):
	emit_signal("player_collided", collision)
