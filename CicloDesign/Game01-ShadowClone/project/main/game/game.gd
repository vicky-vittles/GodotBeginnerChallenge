extends Node2D

func _ready():
	TranslationServer.set_locale("en")

func add_entity(entity):
	add_child(entity)
