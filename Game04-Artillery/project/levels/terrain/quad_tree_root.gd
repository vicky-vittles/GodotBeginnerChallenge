extends Node2D
class_name QuadTreeRoot, "res://levels/terrain/quad-tree-root.svg"

export (Rect2) var boundary
var destruction_map

func create_tree(_map: Array):
	destruction_map = _map
	var root_node = QuadTreeNode.new()
	add_child(root_node)
	root_node.name = "00"
	root_node.global_position = boundary.size/2
	root_node.set_boundary(0, boundary)
	root_node.create(0, destruction_map)
