extends State

var soldier

func enter(_info):
	soldier = fsm.actor

func process(_delta):
	soldier.input_controller.clear_input()
	soldier.input_controller.get_input()

func physics_process(delta):
	var move_dir = soldier.input_controller.move_direction
	soldier.character_mover.set_move_dir(move_dir)
	soldier.character_mover.move(delta)
