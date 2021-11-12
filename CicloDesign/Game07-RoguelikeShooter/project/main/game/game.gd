extends Node2D

export (bool) var randomize_on_ready = false

onready var world = $World

func _ready():
	if randomize_on_ready:
		randomize()

func add_entity(entity):
	world.add_entity(entity)
