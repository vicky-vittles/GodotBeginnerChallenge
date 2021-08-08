extends Node

enum ENTITIES {
	NULL = 0,
	PLAYER = 1,
	ENEMY_ZOMBIE = 2,
	ENEMY_ZOMBIE_CORPSE = 3}

func _process(delta):
	if Input.is_action_just_pressed("sys_reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("sys_exit"):
		get_tree().quit()

func get_game():
	return get_parent().get_node("Game")
