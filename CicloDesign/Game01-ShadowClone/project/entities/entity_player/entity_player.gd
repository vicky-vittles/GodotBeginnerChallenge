extends "res://entities/__entity_platformer_player/__entity_platformer_player.gd"

signal position_updated(pos)
signal info_updated(info)

export (int) var boost_speed = 300
export (float) var boost_max_time = 1.0
export (Vector2) var boost_direction_mask = Vector2(1, 1)
export (float) var clone_time_delay = 1.0

onready var trampoline_trigger = $Body/Triggers/TrampolineTrigger

func _on_DelayTimer_tree_entered():
	get_node("Body/PositionBuffer/DelayTimer").wait_time = clone_time_delay


func _on_PositionBuffer_update_position(pos):
	emit_signal("position_updated", pos)

func _on_Graphics_graphics_updated(info):
	emit_signal("info_updated", info)
