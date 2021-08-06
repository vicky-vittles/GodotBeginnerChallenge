extends QodotEntity
class_name Checkpoint

signal checkpoint_reached(checkpoint)

var checkpoint_id : int = 0

func update_properties():
	checkpoint_id = properties["checkpoint_id"]

func _on_Trigger_effect():
	emit_signal("checkpoint_reached", self)
