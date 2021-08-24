extends GTState

onready var JUMP = $"../Jump"
onready var DIED = $"../Died"
var player

func enter(_info):
	player = fsm.actor

func process(delta):
	player.input_controller.poll_input()

func physics_process(delta):
	player.character_mover.move(delta)

func _on_jump_just_pressed():
	if fsm.current_state == self and player.can_jump():
		fsm.change_state(JUMP)

func _on_player_die():
	if fsm.current_state == self:
		fsm.change_state(DIED)
