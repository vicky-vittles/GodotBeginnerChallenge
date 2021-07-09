extends GTState

onready var IDLE = $"../Idle"
onready var WALK = $"../Walk"
onready var FALL = $"../Fall"

var player

func enter(_info):
	player = fsm.actor
	player.graphics.play("fall")

func process(_delta):
	player.input_controller.poll_input()

func physics_process(delta):
	var move_direction = player.input_controller.get_move_direction()
	player.character_mover.set_move_direction(move_direction)
	player.graphics.orient(move_direction)
	player.character_mover.move(delta)
	
	if player.character_mover.is_grounded():
		fsm.change_state(IDLE)
