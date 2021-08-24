extends GTDeviceController
class_name PlayerController

export (bool) var normalize_direction = true

var move_direction : Vector2

func update_move_direction():
	move_direction = Vector2.ZERO
	move_direction.x = int(get_input("act_move_right", PRESSED)) - int(get_input("act_move_left", PRESSED))
	move_direction.y = int(get_input("act_move_backwards", PRESSED)) - int(get_input("act_move_forwards", PRESSED))
	if normalize_direction:
		move_direction = move_direction.normalized()
