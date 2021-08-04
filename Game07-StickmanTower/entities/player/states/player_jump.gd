extends GTState

onready var FALL = $"../Fall"

func enter(_info = null):
	jump()

func process(_delta):
	actor.input_controller.poll_input()

func physics_process(delta):
	actor.graphics.orient(actor.move_direction)
	actor.entity_mover.set_move_direction(actor.move_direction)
	actor.entity_mover.move(delta)
	
	if actor.entity_mover.velocity.y >= 0:
		fsm.change_state(FALL)

func jump():
	if actor.available_jumps == (actor.max_jumps):
		actor.graphics.play_anim("ground_jump")
	else:
		actor.graphics.play_anim("air_jump")
	actor.entity_mover.jump()
	actor.entity_mover.snap = Vector2.ZERO

func _on_Jump_just_pressed():
	if fsm.current_state == self and actor.can_jump():
		jump()

func _on_Jump_just_released():
	if fsm.current_state == self:
		actor.entity_mover.damp_jump()
