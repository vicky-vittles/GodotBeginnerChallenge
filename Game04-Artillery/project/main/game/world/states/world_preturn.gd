extends State

onready var TURN = $"../Turn"
onready var duration_timer = $DurationTimer
var world

func enter(_info):
	world = fsm.actor
	duration_timer.start()

func go_to_turn():
	if fsm.current_state == self:
		fsm.change_state(TURN)
