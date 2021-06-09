extends Node
class_name InputController

var move_direction : Vector2

func clear_input():
	move_direction = Vector2.ZERO

func get_input():
	move_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
