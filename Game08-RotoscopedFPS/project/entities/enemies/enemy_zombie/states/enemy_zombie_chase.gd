extends GTState

onready var STANDING = $"../Standing"
onready var MELEE = $"../Melee"
onready var PAIN = $"../Pain"
onready var DEAD = $"../Dead"

func enter(_info = null):
	actor.target = actor.get_nearest_player()

func physics_process(delta):
	actor.entity_mover.set_move_direction(actor.move_direction)
	actor.entity_mover.move(delta)
	
	if not actor.is_near_player:
		fsm.change_state(STANDING)

func _on_ReadjustDirectionTimer_timeout():
	actor.update_move_direction_to_target()

func _on_Health_health_lost(current, lost):
	if fsm.current_state == self:
		fsm.change_state(PAIN, { "previous_state": self })

func _on_Health_died(current):
	if fsm.current_state == self:
		fsm.change_state(DEAD)
