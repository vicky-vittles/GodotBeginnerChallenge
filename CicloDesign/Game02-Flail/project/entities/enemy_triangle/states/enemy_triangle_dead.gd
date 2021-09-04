extends GTState

signal died()

func enter(_info = null):
	emit_signal("died")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		actor.call_deferred("queue_free")
