extends State

var soldier
var desired_angle : float = -45.0
var desired_charge : float = 0.0
var is_aiming : bool = true

func enter(_info):
	soldier = fsm.actor

func process(_delta):
	var info = soldier.get_controller_info()
	
	info["desired_angle"] = deg2rad(desired_angle)
	info["desired_charge"] = desired_charge
	info["desired_weapon"] = soldier.weapon_selector.WEAPON_GRENADE
	info["desired_direction"] = sign(soldier.world.get_main_player().global_position.x - soldier.global_position.x)
	
	var current_angle_aim = soldier.get_angle_aim()
	if abs(current_angle_aim-desired_angle) < 1.0:
		desired_charge = 0.5
	
	soldier.input_controller.clear_input()
	soldier.input_controller.get_input(info)
