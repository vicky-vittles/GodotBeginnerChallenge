extends Node
class_name TouchController, "res://libs/gt_input_controller/icons/gt_device_controller.svg"

signal touched(position)

export (bool) var is_active = true
export (float) var cooldown_time = 0.0

var _cooldown_timer : Timer

func _ready():
	_cooldown_timer = Timer.new()
	_cooldown_timer.name = "_CooldownTimer"
	add_child(_cooldown_timer)
	if cooldown_time > 0.0:
		_cooldown_timer.wait_time = cooldown_time
		_cooldown_timer.one_shot = true

func _input(event):
	if event is InputEventMouseButton:
		if is_active and _cooldown_timer.is_stopped():
			_cooldown_timer.start()
			emit_signal("touched", event.position)
