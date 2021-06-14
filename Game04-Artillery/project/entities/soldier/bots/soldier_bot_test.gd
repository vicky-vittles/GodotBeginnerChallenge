extends State

var soldier

func enter(_info):
	soldier = fsm.actor

func process(_delta):
	var info = soldier.get_controller_info()
	info["desired_angle"] = deg2rad(-90.0)
	info["desired_charge"] = 0.5
	
	soldier.input_controller.clear_input()
	soldier.input_controller.get_input(info)
