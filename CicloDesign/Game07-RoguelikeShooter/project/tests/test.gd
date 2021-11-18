extends Node2D

onready var player = $Player

func _ready():
	for child in get_children():
		if child is Entity2D and child.entity_type == Globals.ENTITY_TYPES.ENTITY_CAGE:
			child.player = player

func add_entity(entity):
	add_child(entity)
