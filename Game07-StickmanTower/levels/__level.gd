extends Node2D

signal increase_floor()
signal decrease_floor()

func _on_exit_effect(cause, effect, entity):
	emit_signal("increase_floor")

func _on_falling_trigger_effect():
	emit_signal("decrease_floor")
