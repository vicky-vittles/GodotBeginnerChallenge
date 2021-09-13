extends Node2D

signal player_died()
signal level_started()
signal level_finished()

onready var camera = $Camera
onready var player = $Player

func _ready():
	camera.add_target(player.body)
	emit_signal("level_started")

func end_level():
	emit_signal("level_finished")

func _on_Player_died():
	emit_signal("player_died")
