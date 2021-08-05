extends GTState

onready var CHASE = $"../Chase"
onready var PAIN = $"../Pain"
onready var DEAD = $"../Dead"

func enter(_info = null):
	actor.update_shoot_direction_to_target()
	actor.shoot()

func physics_process(delta):
	actor.entity_mover.set_move_direction(Vector2.ZERO)
	actor.entity_mover.move(delta)

func _on_CooldownTimer_timeout():
	if fsm.current_state == self:
		fsm.change_state(CHASE)

func _on_Health_health_lost(current, lost):
	if fsm.current_state == self:
		fsm.change_state(PAIN, { "previous_state": self })

func _on_Health_died(current):
	if fsm.current_state == self:
		fsm.change_state(DEAD)
