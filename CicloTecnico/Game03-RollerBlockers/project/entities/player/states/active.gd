extends State

onready var INACTIVE = $"../Inactive"
var player

func enter(_info):
	player = fsm.actor

func process(delta):
	player.input_controller.clear_input()
	player.input_controller.get_input()

func physics_process(delta):
	var dir = player.input_controller.direction
	player.body.input(dir)
	player.body.move(delta)

func _on_Player_exited_level_zone():
	if fsm.current_state == self:
		fsm.change_state(INACTIVE)

func _on_Player_entered_win_zone():
	if fsm.current_state == self:
		player.body.disable_triggers()
