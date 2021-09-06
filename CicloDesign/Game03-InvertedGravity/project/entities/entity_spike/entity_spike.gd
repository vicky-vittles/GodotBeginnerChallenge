extends GTEntity2D

export (String) var teleporter_tag = "default"

func _on_Body_tree_entered():
	get_node("Body").tag = teleporter_tag
