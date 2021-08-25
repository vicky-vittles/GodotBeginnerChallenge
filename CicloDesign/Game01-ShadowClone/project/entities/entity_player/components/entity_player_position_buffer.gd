extends Node

signal update_position(pos)

var is_emitting : bool = false
var buffer = []

func _physics_process(delta):
	if not is_emitting:
		return
	if not buffer.empty():
		var current_pos = buffer.pop_front()
		emit_signal("update_position", current_pos)

func add_position(pos):
	buffer.append(pos)

func enable():
	is_emitting = true

func disable():
	is_emitting = false
