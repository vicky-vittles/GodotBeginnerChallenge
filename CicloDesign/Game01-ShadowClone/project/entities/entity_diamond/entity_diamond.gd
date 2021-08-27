extends GTEntity2D

export (String) var teleporter_tag = "default"
export (Globals.TRANSITION_TYPES) var transition_type
export (Globals.EASE_TYPES) var ease_type
export (float) var time_per_point = 1.0
export (bool) var is_loop = true
export (bool) var is_ping_pong = true
export (bool) var is_moving = true

func _on_Body_tree_entered():
	get_node("Body").tag = teleporter_tag

func _on_PointFollow_tree_entered():
	get_node("PointFollow").transition_type = transition_type
	get_node("PointFollow").ease_type = ease_type
	get_node("PointFollow").time_per_point = time_per_point
	get_node("PointFollow").is_loop = is_loop
	get_node("PointFollow").is_ping_pong = is_ping_pong
	get_node("PointFollow").is_moving = is_moving
