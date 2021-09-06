extends Node

enum ENTITY_TYPES {
	NULL = 0,
	PLAYER = 1,
	COIN = 2,
	ENEMY_DIAMOND = 3,
	SPIKE = 4}

func _process(delta):
	if Input.is_action_just_pressed("sys_reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("sys_exit"):
		get_tree().quit()

func get_game():
	pass
