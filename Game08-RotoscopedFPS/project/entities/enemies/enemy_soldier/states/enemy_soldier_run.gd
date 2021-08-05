extends GTState

onready var DEAD = $"../Dead"

func physics_process(delta):
	actor.entity_mover.set_move_direction(actor.move_direction)
	actor.entity_mover.move(delta)

func _on_Health_died(current):
	if fsm.current_state == self:
		fsm.change_state(DEAD)

func _on_Health_health_lost(current, lost):
	if fsm.current_state == self:
		actor.animation_player.play("hurt")
