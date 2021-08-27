extends Node2D

signal level_started()
signal level_finished()

onready var camera = $Camera
onready var player = $Player
onready var cloned_player = $ClonedPlayer

func _ready():
	camera.add_weighted_target(player.body, 2)
	camera.add_weighted_target(cloned_player.body, 1)
	camera.current = true
	emit_signal("level_started")

func end_level():
	emit_signal("level_finished")
