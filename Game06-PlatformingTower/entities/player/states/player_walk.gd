extends GTState

onready var IDLE = $"../Idle"
onready var JUMP = $"../Jump"
onready var FALL = $"../Fall"

var player

func enter(_info):
	player = fsm.actor

func process(_delta):
	player.input_controller.poll_input()

func physics_process(delta):
	var move_direction = player.input_controller.get_move_direction()
	player.character_mover.set_move_direction(move_direction)
	player.character_mover.move(delta)
	
	if player.input_controller.get_jump():
		fsm.change_state(JUMP)
	elif not player.character_mover.is_grounded():
		fsm.change_state(FALL)
	elif move_direction == 0:
		fsm.change_state(IDLE)
