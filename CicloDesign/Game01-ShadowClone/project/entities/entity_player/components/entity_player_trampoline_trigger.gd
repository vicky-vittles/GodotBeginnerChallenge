extends GTArea2D

var can_trampoline : bool = false

func _on_TrampolineTrigger_grouped_area_entered(area):
	can_trampoline = true

func _on_TrampolineTrigger_grouped_area_exited(area):
	can_trampoline = false
