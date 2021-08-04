extends Node

func get_timer_formatted(timer: float) -> String:
	var time = int(timer)
	var seconds = int(time % 60)
	var minutes = int(time / 60)
	var result
	
	if minutes > 0:
		result = "%s:%s" % [minutes, str(seconds).pad_zeros(2)]
	else:
		result = str(seconds).pad_zeros(2)
	return result

func run_acceleration_formula(max_distance, time_to_max_speed):
	return 2*max_distance/(time_to_max_speed*time_to_max_speed)

func run_deceleration_formula(max_speed, time_to_zero_speed):
	return -max_speed/time_to_zero_speed

func gravity_formula(height, time):
	return 2*height/(time*time)

func jump_speed_formula(height, time):
	return -2*height/time
