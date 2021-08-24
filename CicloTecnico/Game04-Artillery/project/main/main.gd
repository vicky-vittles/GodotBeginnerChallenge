extends Node
signal sys_immediate_start()

func _ready():
	if Globals.sys_immediate_start:
		emit_signal("sys_immediate_start")
