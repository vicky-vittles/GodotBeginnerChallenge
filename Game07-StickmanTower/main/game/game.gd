extends Node2D

var level_floors = {}

onready var floors = $Floors

func setup_floors():
	for child in floors.get_children():
		level_floors[int(child.name)] = child
