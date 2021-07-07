extends GTState

onready var WALK = $"../Walk"
onready var JUMP = $"../Jump"

var player

func enter(_info):
	player = fsm.actor

func process(_delta):
	player.input_controller.poll_input()

func physics_process(delta):
	var move_direction = player.input_controller.get_move_direction()
	player.character_mover.set_move_direction(0)
	player.character_mover.move(delta)
	
	if player.input_controller.get_jump():
		fsm.change_state(JUMP)
	elif move_direction != 0:
		fsm.change_state(WALK)
