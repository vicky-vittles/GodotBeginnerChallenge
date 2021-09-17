extends Node

signal resource_points_updated()

func _ready():
	emit_signal("resource_points_updated")

func _on_points_updated(current):
	emit_signal("resource_points_updated")
