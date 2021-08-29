extends Node
class_name AccelerometerController, "res://libs/gt_input_controller/icons/gt_device_controller.svg"

signal update_x(value)
signal update_y(value)
signal update_z(value)
signal update_direction(dir)

export (bool) var is_active = true

func poll_input():
	if not is_active:
		return
	var direction = Input.get_accelerometer()
	emit_signal("update_x", direction.x)
	emit_signal("update_y", direction.y)
	emit_signal("update_z", direction.z)
	emit_signal("update_direction", direction)
