extends Node
class_name GTTime

var pause_timer : Timer

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	pause_timer = Timer.new()
	pause_timer.one_shot = true
	add_child(pause_timer)
	pause_timer.connect("timeout", self, "resume_time")

func pause_time(seconds: float = 0.0) -> void:
	if seconds > 0.0:
		pause_timer.wait_time = seconds
		pause_timer.start()
	get_tree().paused = true

func resume_time() -> void:
	get_tree().paused = false

func slow_time(speed: float = 1.0) -> void:
	Engine.time_scale = speed

func normalize_time() -> void:
	Engine.time_scale = 1.0
