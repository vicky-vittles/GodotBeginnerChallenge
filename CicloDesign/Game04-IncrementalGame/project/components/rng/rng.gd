extends Node

signal random_number(number)

export (Array, int) var random_numbers
export (bool) var emit_result = true

func generate() -> int:
	var rand = randi() % random_numbers.size()
	var rand_number = random_numbers[rand]
	if emit_result:
		emit_signal("random_number", rand_number)
	return rand_number
