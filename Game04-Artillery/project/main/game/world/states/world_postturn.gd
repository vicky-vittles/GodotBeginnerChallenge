extends State

onready var PRE_TURN = $"../Preturn"
onready var duration_timer = $DurationTimer
var world

func enter(_info):
	world = fsm.actor
	duration_timer.start()

func go_to_postturn():
	world.current_player_turn += 1
	world.current_player_turn %= world.get_total_players()
	if fsm.current_state == self:
		fsm.change_state(PRE_TURN)
