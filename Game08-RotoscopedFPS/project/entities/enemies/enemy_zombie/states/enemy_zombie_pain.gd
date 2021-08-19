extends GTState

export (float) var KNOCKBACK_SPEED = 20

onready var CHASE = $"../Chase"
onready var MISSILE = $"../Missile"
onready var PAIN = $"../Pain"
onready var DEAD = $"../Dead"
var previous_state

var knockback_direction : Vector2

func enter(info = null):
	previous_state = info["previous_state"] if info and info.has("previous_state") else null
	var collision_normal = actor.damage_info["player_direction"]
	knockback_direction = Vector2(collision_normal.x, collision_normal.z)
	actor.entity_mover.set_speed_modifier(0.75)

func exit():
	actor.entity_mover.set_speed_modifier(1.0)

func physics_process(delta):
	actor.entity_mover.set_move_direction(knockback_direction)
	actor.entity_mover.move(delta)

func _on_StunTimer_timeout():
	if fsm.current_state == self:
		if not actor.health.is_alive:
			fsm.change_state(DEAD)
		elif previous_state and previous_state != MISSILE:
			fsm.change_state(previous_state)
		else:
			fsm.change_state(CHASE)

func _on_Health_health_lost(current, lost):
	if fsm.current_state == self:
		fsm.change_state(PAIN)

func _on_Health_died(current):
	if fsm.current_state == self:
		fsm.change_state(DEAD)
