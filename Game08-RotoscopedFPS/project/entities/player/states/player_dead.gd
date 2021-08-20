extends GTState

func process(delta):
	actor.input_controller.clear_input()

func physics_process(delta):
	actor.entity_mover.set_move_direction(Vector2.ZERO)
	actor.entity_mover.move(delta)
