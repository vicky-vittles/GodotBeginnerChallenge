extends Node

signal target_updated(new_target)

var targets = []
var current_target

func _ready():
	if targets.size() > 0:
		current_target = targets.front()

func advance_target(cycle: bool):
	var previous_target = targets.pop_front()
	if targets.size() > 0:
		current_target = targets.front()
	if cycle:
		targets.append(previous_target)
	emit_signal("target_updated", current_target)
