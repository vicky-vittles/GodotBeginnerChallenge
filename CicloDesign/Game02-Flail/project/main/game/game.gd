extends Node2D

signal wave_updated()

func add_entity(entity):
	add_child(entity)

func _on_World_wave_updated(wave):
	emit_signal("wave_updated")
