tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("RegularPolygon2D", "Node2D", preload("RegularPolygon2D.gd"), preload("res://addons/regular_polygon2d_node/addon_icon.png"))

func _exit_tree():
	remove_custom_type("RegularPolygon2D")
