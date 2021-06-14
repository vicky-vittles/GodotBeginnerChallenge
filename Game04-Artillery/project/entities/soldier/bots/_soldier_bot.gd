extends "res://entities/soldier/_soldier.gd"

func get_controller_info():
	return {
		"current_angle": get_angle_amount(),
		"current_charge": charge_amount}
