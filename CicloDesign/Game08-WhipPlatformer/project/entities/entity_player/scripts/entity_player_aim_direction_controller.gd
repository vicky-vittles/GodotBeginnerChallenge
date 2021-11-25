extends GTDeviceController

signal updated_air_direction(direction)

var aim_direction : Vector2

func _physics_process(delta):
	aim_direction = Vector2.ZERO
	aim_direction.x = int(get_input("act_aim_right", PRESSED))-int(get_input("act_aim_left", PRESSED))
	aim_direction.y = int(get_input("act_aim_down", PRESSED))-int(get_input("act_aim_up", PRESSED))
	aim_direction = aim_direction.normalized()
	emit_signal("updated_air_direction", aim_direction)
