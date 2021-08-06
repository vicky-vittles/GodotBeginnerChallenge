extends GTTriggerArea3D
class_name Checkpoint

signal checkpoint_reached(checkpoint)

var checkpoint_id : int = 0

func _on_Checkpoint_effect():
	emit_signal("checkpoint_reached", self)
