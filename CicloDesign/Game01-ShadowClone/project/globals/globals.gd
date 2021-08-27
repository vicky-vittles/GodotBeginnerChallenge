extends Node

enum TRANSITION_TYPES {
	TRANS_LINEAR = 0,
	TRANS_SINE = 1,
	TRANS_QUAD = 4,
	TRANS_CUBIC = 7,
	TRANS_QUART = 3,
	TRANS_QUINT = 2,
	TRANS_EXPO = 5,
	TRANS_CIRC = 8,
	TRANS_BACK = 10,
	TRANS_BOUNCE = 9,
	TRANS_ELASTIC = 6}

enum EASE_TYPES {
	EASE_IN = 0,
	EASE_OUT = 1,
	EASE_IN_OUT = 2,
	EASE_OUT_IN = 3}

enum ENTITY_TYPES {
	NULL = 0,
	PLAYER = 1,
	CLONED_PLAYER = 2,
	COIN = 3,
	DIAMOND = 4,
	DOOR = 5,
	SPIKE = 6,
	BUTTON = 7,
	BOOST_EXPLOSION = 8}

func _process(delta):
	if Input.is_action_just_pressed("sys_reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("sys_exit"):
		get_tree().quit()

func get_game():
	return get_node("../Game")
