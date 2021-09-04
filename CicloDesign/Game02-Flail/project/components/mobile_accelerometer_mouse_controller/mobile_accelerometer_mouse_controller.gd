extends Node
class_name MobileAccelerometerMouseController, "res://libs/gt_input_controller/icons/gt_device_controller.svg"

export (float) var movement_threshold = 50

var move_direction : Vector2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		if event.relative.length() > movement_threshold:
			move_direction = event.relative.normalized()
		else:
			move_direction = Vector2.ZERO
