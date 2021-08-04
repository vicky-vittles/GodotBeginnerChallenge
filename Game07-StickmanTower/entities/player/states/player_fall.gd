extends GTState

signal landed()

onready var IDLE = $"../Idle"
onready var RUN = $"../Run"
onready var JUMP = $"../Jump"

func enter(_info = null):
	actor.graphics.play_anim("fall")
	actor.entity_mover.snap = Vector2.DOWN * 16

func process(_delta):
	actor.input_controller.poll_input()

func physics_process(delta):
	actor.graphics.orient(actor.move_direction)
	actor.entity_mover.set_move_direction(actor.move_direction)
	actor.entity_mover.move(delta)
	
	if actor.entity_mover.is_grounded():
		emit_signal("landed")
		if actor.move_direction != 0:
			actor.graphics.play_anim("fall_run")
			fsm.change_state(RUN)
		else:
			actor.graphics.play_anim("fall_idle")
			fsm.change_state(IDLE)

func _on_Jump_just_pressed():
	if fsm.current_state == self and actor.can_jump():
		fsm.change_state(JUMP)
