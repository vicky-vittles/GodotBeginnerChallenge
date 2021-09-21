extends GTState

signal updated_move_direction(direction)

export (bool) var can_poll_input = true
var previous_move_direction : int

func process(delta):
	actor.input_controller.clear_input()
	if can_poll_input:
		actor.input_controller.poll_input()

func physics_process(delta):
	var move_direction = actor.input_controller.move_direction
	if previous_move_direction != move_direction:
		emit_signal("updated_move_direction", move_direction)
	previous_move_direction = move_direction
	actor.entity_mover.set_move_direction(move_direction)
	actor.entity_mover.move(delta)
