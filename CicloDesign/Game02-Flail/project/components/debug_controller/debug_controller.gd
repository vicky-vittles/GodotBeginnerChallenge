extends GTDeviceController

signal updated_direction(direction)

var move_direction : Vector2

func _physics_process(delta):
	var x = int(get_input("act_move_right", PRESSED)) - int(get_input("act_move_left",PRESSED))
	var y = int(get_input("act_move_down", PRESSED)) - int(get_input("act_move_up", PRESSED))
	move_direction = Vector2(x, y)
	emit_signal("updated_direction", move_direction)
