extends GTState

onready var RUN = $"../Run"
onready var JUMP = $"../Jump"

func process(_delta):
	actor.input_controller.poll_input()

func physics_process(delta):
	var move_direction = actor.move_direction
	actor.entity_mover.move(delta)
	
	if move_direction != 0:
		fsm.change_state(RUN)

func _on_Jump_just_pressed():
	if fsm.current_state == self and actor.can_jump():
		fsm.change_state(JUMP)
