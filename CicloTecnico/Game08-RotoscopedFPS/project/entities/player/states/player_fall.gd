extends GTState

onready var IDLE = $"../Idle"
onready var RUN = $"../Run"
onready var DEAD = $"../Dead"

func exit():
	actor.entity_mover.turn_on_snap()

func process(delta):
	actor.input_controller.poll_input()

func physics_process(delta):
	var move_direction = actor.input_controller.move_direction
	actor.entity_mover.set_move_direction(move_direction)
	actor.entity_mover.move(delta)
	
	if actor.entity_mover.is_grounded():
		if move_direction != Vector2.ZERO:
			fsm.change_state(RUN)
		else:
			fsm.change_state(IDLE)

func _on_Player_died():
	if fsm.current_state == self:
		fsm.change_state(DEAD)
