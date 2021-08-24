extends Node

onready var world = $viewport_container/viewport/world

func _ready():
	randomize()

func add_entity(entity):
	world.level.root.map.add_child(entity)
