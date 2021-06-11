extends Node
class_name CharacterMoverFormulas

# Common
func set_gravity_by_height_and_time(jump_height, jump_time):
	return 2*jump_height/(jump_time*jump_time)

func set_y_speed_by_height_and_time(jump_height, jump_time):
	return -2*jump_height/jump_time

# With angle
func set_gravity_by_speed_and_angle_and_maxdistance(speed, angle, max_distance):
	return (speed*speed * sin(2*angle)*sin(2*angle)) / max_distance
