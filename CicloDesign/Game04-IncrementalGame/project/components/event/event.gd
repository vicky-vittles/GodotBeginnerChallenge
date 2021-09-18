extends Node
class_name Event

signal effect()

export (bool) var one_shot = true
export (bool) var timed_event = false
export (float) var time_to_effect = 0.0

var has_activated : bool = false
var _timer : Timer

func _ready():
	if timed_event:
		_timer = Timer.new()
		_timer.one_shot = true
		_timer.wait_time = time_to_effect
		_timer.name = "_Timer"
		_timer.connect("timeout", self, "trigger")
		add_child(_timer)
		_timer.start()

func trigger():
	if has_activated and one_shot:
		return
	has_activated = true
	emit_signal("effect")
