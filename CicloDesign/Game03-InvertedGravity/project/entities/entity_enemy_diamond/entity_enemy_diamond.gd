extends GTEntity2D

export (String) var teleporter_tag = "default"
export (GTPathEntityMover2D.TRANSITION_TYPES) var transition_type
export (GTPathEntityMover2D.EASE_TYPES) var ease_type
export (float) var duration = 1.0
export (bool) var is_loop = true
export (bool) var is_ping_pong = true
export (bool) var is_active = true

func _on_Body_tree_entered():
	get_node("Body").tag = teleporter_tag

func _on_PathEntityMover_tree_entered():
	get_node("Body/PathEntityMover").transition_type = transition_type
	get_node("Body/PathEntityMover").ease_type = ease_type
	get_node("Body/PathEntityMover").duration = duration
	get_node("Body/PathEntityMover").is_loop = is_loop
	get_node("Body/PathEntityMover").is_ping_pong = is_ping_pong
	get_node("Body/PathEntityMover").is_active = is_active
