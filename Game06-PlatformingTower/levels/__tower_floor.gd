extends Node2D

signal changed_floor(new_floor, entity)

export (int) var floor_number = 0

func entity_arrived_at_floor(entity):
	emit_signal("changed_floor", floor_number, entity)

func entity_fell_down(body):
	if body.is_in_group("player"):
		var new_floor = floor_number-1 if floor_number > 1 else 1
		emit_signal("changed_floor", new_floor, body)
