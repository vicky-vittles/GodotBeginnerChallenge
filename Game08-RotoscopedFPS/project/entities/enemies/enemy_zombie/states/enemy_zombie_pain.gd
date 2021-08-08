extends GTState

onready var CHASE = $"../Chase"
onready var MISSILE = $"../Missile"
onready var DEAD = $"../Dead"
var previous_state

func enter(info = null):
	previous_state = info["previous_state"]

func _on_StunTimer_timeout():
	if fsm.current_state == self:
		if not actor.health.is_alive:
			fsm.change_state(DEAD)
		elif previous_state != MISSILE:
			fsm.change_state(previous_state)
		else:
			fsm.change_state(CHASE)
