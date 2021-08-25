extends Node

enum ENTITY_TYPES {
	NULL = 0,
	PLAYER = 1,
	CLONED_PLAYER = 2,
	COIN = 3,
	DIAMOND = 4,
	DOOR = 5,
	SPIKE = 6
	BUTTON = 7}

func _process(delta):
	if Input.is_action_just_pressed("sys_reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("sys_exit"):
		get_tree().quit()
