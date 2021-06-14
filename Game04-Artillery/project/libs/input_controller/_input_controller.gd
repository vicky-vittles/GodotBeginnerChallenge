extends Node
class_name InputController, "res://libs/input_controller/icons/vanilla-controller.svg"

export (bool) var is_active = true

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

func get_input(info = null):
	pass
