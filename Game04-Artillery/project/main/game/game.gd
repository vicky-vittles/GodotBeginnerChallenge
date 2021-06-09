extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("sys_exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("sys_reload"):
		get_tree().reload_current_scene()
