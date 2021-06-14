extends InputController
class_name DeviceController, "res://libs/input_controller/icons/device-controller.svg"

func get_input(info = null):
	if not is_active:
		return
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
