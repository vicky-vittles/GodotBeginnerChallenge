extends GTState

onready var IDLE = $"../Idle"
onready var JUMP = $"../Jump"
onready var FALL = $"../Fall"

func process(_delta):
	actor.graphics.play_anim("run")
	actor.input_controller.poll_input()

func physics_process(delta):
	var move_direction = actor.move_direction
	actor.graphics.orient(move_direction)
	actor.entity_mover.set_move_direction(move_direction)
	actor.entity_mover.move(delta)
	
	if not actor.entity_mover.is_grounded():
		fsm.change_state(FALL)
	elif move_direction == 0:
		fsm.change_state(IDLE)

func _on_Jump_just_pressed():
	if fsm.current_state == self and actor.can_jump():
		fsm.change_state(JUMP)
