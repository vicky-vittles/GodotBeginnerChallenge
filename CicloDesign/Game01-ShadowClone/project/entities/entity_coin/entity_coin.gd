extends GTEntity2D

signal collected()

func _on_Body_effect():
	emit_signal("collected")
