extends GTHealth

signal update_progress(progress)

func _on_health_updated(current):
	emit_signal("update_progress", current/100)
