extends State

var player

func enter(_info):
	player = fsm.actor

func process(delta):
	player.input_controller.clear_input()
	player.input_controller.get_input()

func physics_process(delta):
	if player.input_controller.direction != Vector3.ZERO:
		player.graphics.roll(player.input_controller.direction)

func _on_Graphics_finished_roll_animation():
	pass # Replace with function body.
