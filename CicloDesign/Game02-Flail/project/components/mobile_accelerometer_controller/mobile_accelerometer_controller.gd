extends Node
class_name MobileAccelerometerController, "res://libs/gt_input_controller/icons/gt_device_controller.svg"

signal updated_direction_x(value)
signal updated_direction_y(value)
signal updated_direction_z(value)
signal updated_direction(direction)

export (bool) var is_active = true

func poll_input():
	# Capture sensors
	var accelerometer = Input.get_accelerometer()
	var gravity = Input.get_gravity()
	var direction = accelerometer - gravity
	
	emit_signal("updated_direction_x", direction.x)
	emit_signal("updated_direction_y", direction.y)
	emit_signal("updated_direction_z", direction.z)
	emit_signal("updated_direction", direction)
