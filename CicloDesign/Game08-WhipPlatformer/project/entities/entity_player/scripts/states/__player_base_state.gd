extends GTState

func get_move_direction() -> int:
	return entity.input_controller.move_direction

func get_jump_just_pressed() -> bool:
	return entity.input_controller.get_input("act_jump", GTInputController.JUST_PRESSED)

func get_jump_just_released() -> bool:
	return entity.input_controller.get_input("act_jump", GTInputController.JUST_RELEASED)

func get_attack_just_pressed() -> bool:
	return entity.input_controller.get_input("act_attack", GTInputController.JUST_PRESSED)

func get_crouch_pressed() -> bool:
	return entity.input_controller.get_input("act_crouch", GTInputController.PRESSED)
