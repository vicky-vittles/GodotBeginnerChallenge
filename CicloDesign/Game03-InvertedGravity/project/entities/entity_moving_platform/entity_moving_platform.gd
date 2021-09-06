extends GTEntity2D

export (GTPathEntityMover2D.TRANSITION_TYPES) var transition_type
export (GTPathEntityMover2D.EASE_TYPES) var ease_type
export (float) var duration = 1.0

func _on_PathEntityMover_tree_entered():
	get_node("Body/PathEntityMover").transition_type = transition_type
	get_node("Body/PathEntityMover").ease_type = ease_type
	get_node("Body/PathEntityMover").duration = duration
