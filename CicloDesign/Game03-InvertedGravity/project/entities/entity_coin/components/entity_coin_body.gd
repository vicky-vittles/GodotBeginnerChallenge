extends GTTriggerArea2D

signal start_floating(amplitude, time, delay)

export (float) var amplitude = 16.0
export (float) var time = 1.0
var delay : float

onready var repeat_timer = $Graphics/color/floating/RepeatTimer

func _ready():
	delay = randf()
	play_anim()

func play_anim():
	emit_signal("start_floating", amplitude, time, delay)
	repeat_timer.start()
