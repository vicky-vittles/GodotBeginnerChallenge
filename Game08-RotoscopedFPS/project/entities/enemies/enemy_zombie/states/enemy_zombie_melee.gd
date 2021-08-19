extends GTState

onready var CHASE = $"../Chase"
onready var PAIN = $"../Pain"
onready var DEAD = $"../Dead"

func _on_DurationTimer_timeout():
	if fsm.current_state == self:
		fsm.change_state(CHASE)

func _on_Health_health_lost(current, lost):
	if fsm.current_state == self:
		fsm.change_state(PAIN)

func _on_Health_died(current):
	if fsm.current_state == self:
		fsm.change_state(DEAD)
