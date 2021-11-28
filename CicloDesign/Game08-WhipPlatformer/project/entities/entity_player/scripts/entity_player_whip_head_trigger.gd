extends GTTriggerArea2D

signal triggered_grab(area)
signal triggered_swing(area)

const STR_GRABBABLE = "grabbable"
const STR_SWINGABLE = "swingable"

func _on_area_entered(area):
	if area.is_in_group(STR_GRABBABLE):
		emit_signal("triggered_grab", area)
	elif area.is_in_group(STR_SWINGABLE):
		emit_signal("triggered_swing", area)
