extends GTState

onready var FALL = $"../Fall"

func enter(_info = null):
	actor.entity_mover.jump()
	actor.entity_mover.snap = Vector2.ZERO

func process(_delta):
	actor.input_controller.poll_input()

func physics_process(delta):
	actor.entity_mover.set_move_direction(actor.move_direction)
	actor.entity_mover.move(delta)
	
	if actor.entity_mover.velocity.y >= 0:
		fsm.change_state(FALL)

func _on_Jump_just_pressed():
	if fsm.current_state == self and actor.can_jump():
		actor.entity_mover.jump()

func _on_Jump_just_released():
	if fsm.current_state == self:
		actor.entity_mover.damp_jump()
