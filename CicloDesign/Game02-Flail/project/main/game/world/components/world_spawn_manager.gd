extends Node

const WORLD_CENTER = Vector2(270, 480)
export (int) var target_pos_random_radius = 64
export (float) var enemy_random_speed = 0.0

export (NodePath) var world_path
onready var world = get_node(world_path)

onready var enemy_spawner = $EnemySpawner
onready var enemy_spawn_zone = $EnemySpawnZone

func spawn_enemy(max_speed):
	max_speed += randf()*enemy_random_speed*max_speed
	var info = calculate_traversing_behavior(max_speed)
	var entity = enemy_spawner.spawn_with_info(info)

func calculate_traversing_behavior(max_speed) -> Dictionary:
	var pos = enemy_spawn_zone.random_point()
	var center_offset = WORLD_CENTER-pos
	var target_pos_1 = WORLD_CENTER+center_offset+Utils.rand_direction()*target_pos_random_radius
	var target_pos_2 = WORLD_CENTER-center_offset+Utils.rand_direction()*target_pos_random_radius
	var info = {
		"position": pos,
		"targets": [target_pos_1, target_pos_2],
		"max_speed": max_speed}
	return info
