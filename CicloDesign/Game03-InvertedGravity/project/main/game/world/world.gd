extends Node2D

signal level_started()
signal level_finished()
signal load_level(level_id, with_delay)

const LEVEL_SCENES = {
	0: preload("res://levels/levels/L00.tscn"),
	1: preload("res://levels/levels/L01.tscn"),
	2: preload("res://levels/levels/L02.tscn"),
	3: preload("res://levels/levels/L03.tscn"),
	4: preload("res://levels/levels/L04.tscn"),
	5: preload("res://levels/levels/L05.tscn"),
	6: preload("res://levels/levels/L06.tscn")}

export (int) var current_level = 0

func _ready():
	emit_signal("load_level", current_level, false)

func level_started():
	emit_signal("level_started")

func level_finished():
	emit_signal("level_finished")
	current_level += 1
	emit_signal("load_level", current_level, true)
