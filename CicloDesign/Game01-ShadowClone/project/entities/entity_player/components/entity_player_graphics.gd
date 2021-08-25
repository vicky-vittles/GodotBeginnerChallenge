extends Node2D

signal graphics_updated(info)

export (bool) var do_update = true

func _physics_process(delta):
	if do_update:
		var new_info = {}
		emit_signal("graphics_updated", new_info)
