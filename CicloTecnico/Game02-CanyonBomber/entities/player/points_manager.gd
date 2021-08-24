extends Node
signal update_points(points)

const NOTIFY_LABEL = preload("res://libs/notify_label/notify_label.tscn")

onready var player = get_parent()
var points : int = 0

func add_points(_p):
	points += _p
	var label = NOTIFY_LABEL.instance()
	player.effects.add_child(label)
	label.scale.x = sign(player.direction.x)
	label.init("+" + str(_p))
	emit_signal("update_points", points)
