extends Timer
signal update_time(time)
signal soon_timeout()

var soon_timeout : bool = false

func _physics_process(delta):
	emit_signal("update_time", time_left)
	if time_left < 10 and not soon_timeout:
		soon_timeout = true
		emit_signal("soon_timeout")
