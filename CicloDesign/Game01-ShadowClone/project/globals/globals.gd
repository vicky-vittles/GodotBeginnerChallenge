extends Node

enum ENTITY_TYPES {
	NULL = 0,
	PLAYER = 1,
	CLONED_PLAYER = 2,
	COIN = 3,
	ENEMY_DIAMOND = 4,
	SIMPLE_DOOR = 5,
	SPIKE = 6
	GROUND_BUTTON = 7}

func _process(delta):
	if Input.is_action_just_pressed("sys_reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("sys_exit"):
		get_tree().quit()
