extends GTState

signal took_damage()
signal died()

func _on_Health_health_lost(current, lost):
	emit_signal("took_damage")
