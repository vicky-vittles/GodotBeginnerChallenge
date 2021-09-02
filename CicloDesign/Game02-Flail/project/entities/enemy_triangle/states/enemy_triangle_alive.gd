extends GTState

signal reached_target()

var reached_target : bool = false

func physics_process(delta):
	if not actor.entity_mover.target:
		return
	actor.entity_mover.move(delta)
	actor.body.orient(actor.entity_mover.velocity.normalized())
	
	var dist = actor.body.global_position.distance_squared_to(actor.entity_mover.target)
	if dist < 1000 and not reached_target:
		reached_target = true
		emit_signal("reached_target")

func _on_TargetManager_target_updated(new_target):
	if fsm.current_state == self and reached_target:
		reached_target = false
		actor.entity_mover.target = new_target
