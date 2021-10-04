extends Node2D

onready var player = $Player
onready var enemies = $Enemies
onready var camera = $Camera

func _ready():
	for child in enemies.get_children():
		child.set_target(player.body)
