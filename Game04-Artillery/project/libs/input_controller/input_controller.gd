extends Node
class_name InputController, "res://libs/input_controller/vanilla-controller.svg"

var move_direction : Vector2
var aim_direction : int
var charge_press : bool
var charge_hold : bool
var charge_released : bool

func clear_input():
	move_direction = Vector2.ZERO
	aim_direction = 0
	charge_press = false
	charge_hold = false

func get_input():
	move_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	aim_direction = int(Input.is_action_pressed("look_up")) - int(Input.is_action_pressed("look_down"))
	charge_press = Input.is_action_just_pressed("charge")
	charge_hold = Input.is_action_pressed("charge")
	charge_released = Input.is_action_just_released("charge")
