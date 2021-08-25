extends GTTriggerArea2D

signal pressed()
signal released()

func _on_ActivationTrigger_grouped_area_entered(area):
	emit_signal("pressed")

func _on_ActivationTrigger_grouped_area_exited(area):
	emit_signal("released")
