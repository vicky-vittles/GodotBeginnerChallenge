extends GTDeviceController

func get_move_direction() -> int:
	var direction = int(get_input("act_move_right", PRESSED)) - int(get_input("act_move_left", PRESSED))
	return direction

func get_jump() -> bool:
	var jump = get_input("act_jump", JUST_PRESSED)
	return jump
