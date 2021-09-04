extends Node

const PALETTE_COLORS = [
	Color("#00303b"),
	Color("#ff7777"),
	Color("#ffce96"),
	Color("#f1f2da")]

enum ENTITY_TYPES {
	NULL = 0,
	PLAYER = 1,
	ENEMY_TRIANGLE = 2}

var current_score : int = 0

func _process(delta):
	if Input.is_action_just_pressed("sys_reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("sys_exit"):
		get_tree().quit()

func get_game():
	pass
