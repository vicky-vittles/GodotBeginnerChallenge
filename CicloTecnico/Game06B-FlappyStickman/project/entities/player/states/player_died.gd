extends GTState

func enter(_info):
	actor.graphics.play_anim("die")

func process(delta):
	actor.input_controller.clear_input()

func physics_process(delta):
	actor.character_mover.move(delta)
