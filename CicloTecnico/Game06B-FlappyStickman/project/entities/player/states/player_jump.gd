extends GTState

onready var FALL = $"../Fall"
onready var DIED = $"../Died"
var player

func enter(_info):
	player = fsm.actor
	player.character_mover.jump()

func process(delta):
	player.input_controller.poll_input()

func physics_process(delta):
	player.character_mover.move(delta)
	if player.character_mover.velocity.y >= 0:
		fsm.change_state(FALL)

func _on_jump_just_pressed():
	if fsm.current_state == self and player.can_jump():
		player.character_mover.jump()

func _on_jump_just_released():
	if fsm.current_state == self:
		player.character_mover.damp_jump()

func _on_player_die():
	if fsm.current_state == self:
		fsm.change_state(DIED)
