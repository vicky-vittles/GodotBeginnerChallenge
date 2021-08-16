extends GTState

signal fall_thud()

onready var IDLE = $"../Idle"
onready var RUN = $"../Run"

var velocity

func exit():
	if velocity.y < -30:
		emit_signal("fall_thud")
	actor.entity_mover.turn_on_snap()

func process(delta):
	actor.input_controller.poll_input()

func physics_process(delta):
	if actor.entity_mover.velocity.length() > 1.0:
		velocity = actor.entity_mover.velocity
	
	var move_direction = actor.input_controller.move_direction
	actor.entity_mover.set_move_direction(move_direction)
	actor.entity_mover.move(delta)
	
	if actor.entity_mover.is_grounded():
		if move_direction != Vector2.ZERO:
			fsm.change_state(RUN)
		else:
			fsm.change_state(IDLE)
