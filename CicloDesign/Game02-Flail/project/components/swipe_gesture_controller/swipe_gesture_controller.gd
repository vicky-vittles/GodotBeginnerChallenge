extends Node
class_name SwipeGestureController, "res://libs/gt_input_controller/icons/gt_device_controller.svg"

signal swiped(direction)
signal swiped_info(start_position, end_position)
signal swipe_canceled(start_position)

export (float, 1.0, 1.5) var max_diagonal_slope = 1.3
export (float) var swipe_window_time = 0.15
export (bool) var is_active = true
export (bool) var block_diagonals = false
export (bool) var limit_directions = false
export (bool) var is_inverted = false

onready var timer = $Timer
var start_position = Vector2()
var invert_mask : int

func _ready():
	invert_mask = 1 if not is_inverted else -1

func _input(event):
	if not is_active:
		return
	if not event is InputEventScreenTouch:
		return
	if event.pressed:
		start_detection(event.position)
	elif not timer.is_stopped():
		end_detection(event.position)

func start_detection(pos):
	start_position = pos
	timer.start()

func end_detection(pos):
	timer.stop()
	var distance = pos - start_position
	var direction = distance.normalized()
	if limit_directions:
		if block_diagonals and abs(direction.x) + abs(direction.y) >= max_diagonal_slope:
			return
		if abs(direction.x) > abs(direction.y):
			emit_signal("swiped", Vector2(invert_mask*sign(direction.x), 0))
		else:
			emit_signal("swiped", Vector2(0, invert_mask*sign(direction.y)))
		emit_signal("swiped_info", start_position, pos)
	else:
		emit_signal("swiped", invert_mask*direction)
		emit_signal("swiped_info", start_position, pos)

func _on_Timer_timeout():
	emit_signal("swipe_canceled", start_position)
