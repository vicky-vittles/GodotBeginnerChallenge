extends Node2D

func _ready():
	randomize()

func add_entity(entity):
	add_child(entity)
