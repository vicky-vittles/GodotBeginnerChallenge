extends Node2D

signal floor_updated(new_floor)

export (int) var initial_floor = 1
export (int) var max_floors = 10
var level_floors = {}
var current_floor_number : int = 0
var current_floor

onready var floors = $Floors
onready var camera = $Camera

func _ready():
	setup_floors()

func setup_floors():
	for child in floors.get_children():
		level_floors[int(child.name)] = child
		child.connect("increase_floor", self, "update_floor", [1])
		child.connect("decrease_floor", self, "update_floor", [-1])
	update_floor(initial_floor)

func update_floor(new_floor):
	current_floor_number = clamp(current_floor_number + new_floor, 1, max_floors)
	current_floor = level_floors[current_floor_number]
	camera.clear_targets()
	camera.add_target(current_floor)
	emit_signal("floor_updated", current_floor_number)
	
	for child in floors.get_children():
		if child.name == str(current_floor_number):
			child.activate()
		else:
			child.deactivate()
