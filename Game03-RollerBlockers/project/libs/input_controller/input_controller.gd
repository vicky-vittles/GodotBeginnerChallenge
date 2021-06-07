extends Node
class_name InputController

var direction : Vector3

func clear_input():
	direction = Vector3.ZERO

func get_input():
	direction.x = int(Input.is_action_just_pressed("right")) - int(Input.is_action_just_pressed("left"))
	if direction.x == 0:
		direction.z = int(Input.is_action_just_pressed("down")) - int(Input.is_action_just_pressed("up"))
