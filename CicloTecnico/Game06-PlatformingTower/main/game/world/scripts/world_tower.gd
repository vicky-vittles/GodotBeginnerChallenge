extends Node2D

signal update_current_floor(floor_node)
signal update_player_pos(new_pos)

func _ready():
	for child in get_children():
		child.connect("changed_floor", self, "_on_TowerFloor_changed_floor")
		child.connect("player_touched_enemy", self, "_on_TowerFloor_player_touched_enemy")

func _on_TowerFloor_changed_floor(floor_number, _entity):
	emit_signal("update_current_floor", get_child(floor_number-1))

func _on_TowerFloor_player_touched_enemy(new_pos):
	emit_signal("update_player_pos", new_pos)
