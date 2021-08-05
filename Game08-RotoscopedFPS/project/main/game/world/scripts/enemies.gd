extends Spatial

const ENEMY_SOLDIER = preload("res://entities/enemies/enemy_soldier/enemy_soldier.tscn")

#onready var enemy_spawn_zone = $EnemySpawnZone
#
#func spawn_enemy():
#	var enemy = ENEMY_SOLDIER.instance()
#	add_child(enemy)
#	enemy.global_transform.origin = enemy_spawn_zone.random_point()
