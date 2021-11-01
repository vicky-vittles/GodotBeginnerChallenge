extends Node2D

onready var room = $"1"
onready var player = $Player

func _ready():
	room.configure_player(player)

func add_entity(entity):
	room.add_entity(entity)
