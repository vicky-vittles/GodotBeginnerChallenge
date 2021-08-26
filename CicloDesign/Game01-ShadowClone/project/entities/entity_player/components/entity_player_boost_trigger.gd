extends GTArea2D

var can_boost : bool = false
var clone_entity

func _on_TrampolineTrigger_grouped_area_entered(area):
	clone_entity = area
	can_boost = true

func _on_TrampolineTrigger_grouped_area_exited(area):
	clone_entity = null
	can_boost = false
