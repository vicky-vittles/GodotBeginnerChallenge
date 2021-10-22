extends Node2D

signal spawned_enemy(info)

export (int) var min_distance_from_player = 300

onready var enemy_spawn_zone = $EnemySpawnZone
onready var player = $Player
onready var camera = $Camera

func _on_WaveManager_spawned_enemy(info):
	var rand_pos = Vector2.ZERO
	var dist = 0
	while dist < min_distance_from_player:
		rand_pos = enemy_spawn_zone.random_point()
		dist = rand_pos.distance_to(player.body.global_position)
	info["global_position"] = rand_pos
	info["target"] = player.body
	emit_signal("spawned_enemy", info)
