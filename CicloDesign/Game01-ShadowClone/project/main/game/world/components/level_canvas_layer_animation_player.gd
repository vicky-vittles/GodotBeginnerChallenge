extends AnimationPlayer

signal finished_fade_in()
signal finished_fade_out()

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_in":
		emit_signal("finished_fade_in")
	elif anim_name == "fade_out":
		emit_signal("finished_fade_out")
