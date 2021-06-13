extends Node
class_name InputController, "res://libs/input_controller/vanilla-controller.svg"

var move_direction : Vector2
var last_move_direction : int = 1
var aim_direction : int
var weapon_selected : int
var charge_press : bool
var charge_hold : bool
var charge_released : bool

func clear_input():
	move_direction = Vector2.ZERO
	aim_direction = 0
	weapon_selected = 0
	charge_press = false
	charge_hold = false

func get_input():
	move_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if move_direction.x != 0:
		last_move_direction = move_direction.x
	
	weapon_selected = 0
	for i in range(1,9+1):
		weapon_selected = i if Input.is_action_just_pressed("weapon_%s" % [str(i)]) else weapon_selected
	
	aim_direction = int(Input.is_action_pressed("look_up")) - int(Input.is_action_pressed("look_down"))
	charge_press = Input.is_action_just_pressed("charge")
	charge_hold = Input.is_action_pressed("charge")
	charge_released = Input.is_action_just_released("charge")
