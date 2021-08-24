extends GTState

onready var FALL = $"../Fall"

var player

func enter(_info):
	player = fsm.actor
	player.character_mover.jump()
	player.graphics.play("jump")

func process(_delta):
	player.input_controller.poll_input()

func physics_process(delta):
	var move_direction = player.input_controller.get_move_direction()
	player.character_mover.set_move_direction(move_direction)
	player.graphics.orient(move_direction)
	player.character_mover.move(delta)
	
	if player.character_mover.velocity.y >= 0:
		fsm.change_state(FALL)
