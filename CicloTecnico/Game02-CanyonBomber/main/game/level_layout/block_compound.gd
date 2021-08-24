extends Area2D

signal block_destroyed(player_id, level)

export (int) var level = 0

func _ready():
	for block in get_children():
		if block.is_in_group("block"):
			block.connect("destroyed", self, "_on_Block_destroy")

func _on_Block_destroy(player_id, _level):
	emit_signal("block_destroyed", player_id, _level)

func _on_area_entered(area):
	if area.is_in_group("block"):
		area.set_level(level)
