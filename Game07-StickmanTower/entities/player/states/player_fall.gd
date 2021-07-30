extends GTState

signal landed()

onready var IDLE = $"../Idle"
onready var JUMP = $"../Jump"

func enter(_info = null):
	actor.entity_mover.snap = Vector2.DOWN * 16

func process(_delta):
	actor.input_controller.poll_input()

func physics_process(delta):
	actor.entity_mover.set_move_direction(actor.move_direction)
	actor.entity_mover.move(delta)
	
	if actor.is_grounded():
		emit_signal("landed")
		fsm.change_state(IDLE)

func _on_Jump_just_pressed():
	if fsm.current_state == self and actor.can_jump():
		fsm.change_state(JUMP)
