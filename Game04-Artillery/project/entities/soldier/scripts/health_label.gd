extends Label

func _on_Health_health_updated(current):
	text = str(int(current))
