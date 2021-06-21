extends State

onready var POST_TURN = $"../Postturn"
onready var duration_timer = $DurationTimer
var world

func enter(_info):
	world = fsm.actor
	duration_timer.start()
	
	world.get_current_player().input_controller.is_active = true
	world.get_current_player().can_shoot = true

func go_to_postturn():
	if fsm.current_state == self:
		fsm.change_state(POST_TURN)

func _on_World_projectile_exploded(projectile, explosions):
	if fsm.current_state == self:
		duration_timer.stop()
		fsm.change_state(POST_TURN)
