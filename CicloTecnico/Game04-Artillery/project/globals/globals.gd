extends Node

var sys_immediate_start : bool

func _ready():
	sys_immediate_start = false

func get_game():
	return get_node("../Game")
