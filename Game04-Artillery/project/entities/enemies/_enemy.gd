extends Node2D
class_name Enemy

onready var bit_entity_mover = $BitEntityMover

var collision_map = []

func _physics_process(delta):
	bit_entity_mover.fall()
