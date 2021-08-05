extends GTState

onready var RUN = $"../Run"
onready var DEAD = $"../Dead"

func physics_process(delta):
	if actor.move_direction != Vector2.ZERO:
		fsm.change_state(RUN)
	actor.entity_mover.move(delta)

func _on_Health_died(current):
	if fsm.current_state == self:
		fsm.change_state(DEAD)
