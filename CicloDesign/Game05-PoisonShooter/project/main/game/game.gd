extends Node2D

export (bool) var randomize_on_ready = false
export (bool) var unpause_on_ready = true

onready var world = $World

func _ready():
	if randomize_on_ready:
		randomize()
	if unpause_on_ready:
		get_tree().paused = false

func add_entity(entity):
	world.bombs.add_child(entity)
