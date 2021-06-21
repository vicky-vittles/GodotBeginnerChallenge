extends State

onready var PRE_TURN = $"../Preturn"
var world

func enter(_info):
	world = fsm.actor

func go_to_preturn():
	world.current_player_turn += 1
	world.current_player_turn %= world.get_total_players()
	
	if fsm.current_state == self:
		fsm.change_state(PRE_TURN)
