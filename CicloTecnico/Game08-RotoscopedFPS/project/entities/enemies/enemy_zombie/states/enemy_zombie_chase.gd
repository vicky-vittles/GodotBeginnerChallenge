extends GTState

onready var STANDING = $"../Standing"
onready var MELEE = $"../Melee"
onready var PAIN = $"../Pain"
onready var DEAD = $"../Dead"

func enter(_info = null):
	actor.target = actor.get_nearest_player()

func physics_process(delta):
	var move_direction = actor.move_direction
	
	if actor.target:
		if not actor.target.health.is_alive:
			fsm.change_state(STANDING)
		var target_pos = actor.target.global_transform.origin
		var my_pos = actor.global_transform.origin
		var dist = my_pos.distance_to(target_pos)
		if dist <= actor.ATTACK_REACH:
			move_direction = Vector2.ZERO
			if actor.melee_cooldown_timer.is_stopped():
				fsm.change_state(MELEE)
			
	actor.entity_mover.set_move_direction(move_direction)
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
