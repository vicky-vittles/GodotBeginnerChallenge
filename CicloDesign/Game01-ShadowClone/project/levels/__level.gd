extends Node2D

signal level_started()
signal level_finished()

func _ready():
	emit_signal("level_started")

func end_level():
	emit_signal("level_finished")
