extends State

var player

func enter(_info):
	player = fsm.actor

func process(delta):
	player.input_controller.clear_input()

func physics_process(_delta):
	player.body.gravity_scale = 4

func _on_Player_entered_win_zone():
	if fsm.current_state == self:
		player.body.disable_triggers()
