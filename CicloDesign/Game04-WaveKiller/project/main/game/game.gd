extends Node2D

func _ready():
	#randomize()
	pass

func add_entity(entity):
	get_node("World/Entities").add_child(entity)
