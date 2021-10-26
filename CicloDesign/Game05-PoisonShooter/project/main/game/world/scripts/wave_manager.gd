extends "res://components/entity_spawner/nst_manager/nst_manager.gd"

const STR_RANDOM_STRENGTH = "random_strength"

export (NodePath) var _player_path
export (float) var min_distance_to_player = 300

onready var player = get_node(_player_path)

func set_enemy_info():
	var rand_pos = Vector2.ZERO
	var dist = 0
	while dist < min_distance_to_player:
		rand_pos = random_point()
		dist = rand_pos.distance_to(player.body.global_position)
	
	var info = {
		"global_position": rand_pos}
	var random_strength = get_enemy_property(STR_RANDOM_STRENGTH)
	info["strength"] = rand_range(1.0, random_strength)
	return info
