extends Node
class_name InputController

var bomb_press : bool = false
var bomb_hold : bool = false

func clear_input():
	bomb_press = false
	bomb_hold = false

func get_input():
	bomb_press = Input.is_action_just_pressed("bomb")
	bomb_hold = Input.is_action_pressed("bomb")
