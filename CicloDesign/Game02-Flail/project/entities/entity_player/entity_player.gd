extends GTEntity2D

onready var input_controller = $MobileShakeController
onready var entity_mover = $Body/EntityMover

func _physics_process(delta):
	input_controller.poll_input()
	var move_direction = input_controller.move_direction
	entity_mover.set_move_direction(move_direction)
	entity_mover.move(delta)
