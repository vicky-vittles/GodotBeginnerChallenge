extends Node

func get_int_pos(pos: Vector2):
	return Vector2(int(pos.x), int(pos.y))

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
