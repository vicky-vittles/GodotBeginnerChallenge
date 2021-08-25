extends GTEntity2D

signal collected()

export (float) var animation_delay = 0.0

func _on_Graphics_tree_entered():
	get_node("Graphics").anim_delay = animation_delay

func _on_Body_effect():
	emit_signal("collected")
