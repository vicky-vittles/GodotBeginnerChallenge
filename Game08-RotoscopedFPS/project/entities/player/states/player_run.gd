extends GTState

onready var IDLE = $'../Idle'
onready var JUMP = $"../Jump"
onready var FALL = $"../Fall"

onready var footsteps_timer = $FootstepsTimer
onready var coyote_timer = $CoyoteTimer

func exit():
	coyote_timer.stop()

func process(delta):
	actor.input_controller.poll_input()

func physics_process(delta):
	var move_direction = actor.input_controller.move_direction
	actor.entity_mover.set_move_direction(move_direction)
	
	if not actor.entity_mover.is_grounded() and coyote_timer.is_stopped():
		coyote_timer.start()
	
	if move_direction == Vector2.ZERO:
		fsm.change_state(IDLE)
	actor.entity_mover.move(delta)

func _on_jump_just_pressed():
	if fsm.current_state == self and actor.can_jump:
		fsm.change_state(JUMP)

func _on_CoyoteTimer_timeout():
	if fsm.current_state == self and not actor.entity_mover.is_grounded():
		fsm.change_state(FALL)
