extends Node2D

signal increase_floor()
signal decrease_floor()

onready var falling_trigger = $root/falling_trigger

func activate():
	falling_trigger.set_deferred("monitoring", true)

func deactivate():
	falling_trigger.set_deferred("monitoring", false)

func _on_exit_teleported_entity(entity):
	emit_signal("increase_floor")

func _on_falling_trigger_effect():
	emit_signal("decrease_floor")
