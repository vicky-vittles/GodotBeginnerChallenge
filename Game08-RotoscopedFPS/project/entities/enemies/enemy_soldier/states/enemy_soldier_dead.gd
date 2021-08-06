extends GTState

func enter(_info = null):
	actor.corpse_spawner.spawn_corpse(actor.global_transform.origin, actor.rotation)
	actor.animation_player.play("die")

func physics_process(delta):
	actor.entity_mover.set_move_direction(Vector2.ZERO)
	actor.entity_mover.move(delta)

func _on_AnimationPlayer_animation_finished(anim_name):
	if fsm.current_state == self and anim_name == "die":
		actor.call_deferred("queue_free")
