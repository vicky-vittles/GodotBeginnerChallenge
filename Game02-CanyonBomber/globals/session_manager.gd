extends Node

enum REPLAY_TYPE { FORCED, GAME_OVER }
var replay_type_chosen = REPLAY_TYPE.GAME_OVER

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
