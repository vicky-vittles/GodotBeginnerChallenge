extends State

onready var TURN = $"../Turn"
onready var duration_timer = $DurationTimer

var focused_on_new_player : bool = false
var world

func enter(_info):
	world = fsm.actor
	duration_timer.start()
	focused_on_new_player = false
	
	for player in world.players.get_children():
		player.input_controller.is_active = false
		player.can_shoot = false

func process(_delta):
	if not focused_on_new_player:
		focused_on_new_player = true
		world.emit_signal("camera_focus_on_player", world.get_current_player())

func go_to_turn():
	if fsm.current_state == self:
		fsm.change_state(TURN)
