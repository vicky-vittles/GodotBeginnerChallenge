extends Node2D

signal spawned_enemy(info)

onready var enemy_spawn_zone = $EnemySpawnZone
onready var player = $Player
onready var camera = $Camera

func _on_WaveManager_spawned_enemy(info):
	var rand_pos = enemy_spawn_zone.random_point()
	info["global_position"] = rand_pos
	info["target"] = player.body
	emit_signal("spawned_enemy", info)
