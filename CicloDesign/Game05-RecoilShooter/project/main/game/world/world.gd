extends Node2D

onready var player = $Player
onready var camera = $Camera

func _ready():
	camera.add_target(player.body)
