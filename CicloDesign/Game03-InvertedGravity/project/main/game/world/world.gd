extends Node2D

signal level_started()
signal level_finished()
signal load_level(level_id, with_delay)

const LEVEL_SCENES = {
	0: preload("res://levels/levels/L00-Test.tscn"),
	1: preload("res://levels/levels/L01-Tutorial.tscn"),
	2: preload("res://levels/levels/L02.tscn")}

export (int) var current_level = 0

func _ready():
	emit_signal("load_level", current_level, false)

func level_started():
	emit_signal("level_started")

func level_finished():
	emit_signal("level_finished")
	current_level += 1
	emit_signal("load_level", current_level, true)
