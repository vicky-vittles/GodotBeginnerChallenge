extends Node

const WORLD_CENTER = Vector2(270, 480)
const TARGET_POS_RANDOM_RADIUS = 64

export (NodePath) var world_path
onready var world = get_node(world_path)

onready var enemy_spawner = $EnemySpawner
onready var enemy_spawn_zone = $EnemySpawnZone

func spawn_enemy():
	var info = calculate_traversing_behavior()
	var entity = enemy_spawner.spawn_with_info(info)

func calculate_traversing_behavior() -> Dictionary:
	var pos = enemy_spawn_zone.random_point()
	var center_offset = WORLD_CENTER-pos
	var target_pos_1 = WORLD_CENTER+center_offset+Utils.rand_direction()*TARGET_POS_RANDOM_RADIUS
	var target_pos_2 = WORLD_CENTER-center_offset+Utils.rand_direction()*TARGET_POS_RANDOM_RADIUS
	var info = {
		"position": pos,
		"targets": [target_pos_1, target_pos_2]}
	return info
