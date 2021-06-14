extends State

onready var POST_TURN = $"../Postturn"
onready var duration_timer = $DurationTimer
var world

func enter(_info):
	world = fsm.actor
	duration_timer.start()

func go_to_postturn():
	if fsm.current_state == self:
		fsm.change_state(POST_TURN)
