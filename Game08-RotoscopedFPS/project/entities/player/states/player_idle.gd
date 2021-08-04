extends GTState

onready var RUN = $"../Run"
onready var JUMP = $"../Jump"

func process(delta):
	actor.input_controller.poll_input()
	
func physics_process(delta):
	var move_direction = actor.input_controller.move_direction
	actor.entity_mover.set_move_direction(Vector2.ZERO)
	
	if move_direction != Vector2.ZERO:
		fsm.change_state(RUN)
	actor.entity_mover.move(delta)

func _on_jump_just_pressed():
	if fsm.current_state == self:
		fsm.change_state(JUMP)
