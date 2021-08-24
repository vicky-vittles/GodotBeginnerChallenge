extends Timer

signal left_foot()
signal right_foot()

var is_left_foot : bool = false

func _on_timeout():
	if is_left_foot:
		emit_signal("left_foot")
	else:
		emit_signal("right_foot")
	is_left_foot = !is_left_foot
