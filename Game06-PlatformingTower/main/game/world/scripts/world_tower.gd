extends Node2D

signal update_current_floor(floor_node)

func _ready():
	for child in get_children():
		child.connect("changed_floor", self, "_on_TowerFloor_changed_floor")

func _on_TowerFloor_changed_floor(floor_number, _entity):
	emit_signal("update_current_floor", get_child(floor_number-1))
