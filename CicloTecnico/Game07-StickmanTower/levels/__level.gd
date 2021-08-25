extends Node2D

signal increase_floor()
signal decrease_floor()

onready var falling_trigger = $root/falling_trigger
onready var enemies = $root/enemies

func _ready():
	for enemy in enemies.get_children():
		enemy.tag = self.name

func activate():
	falling_trigger.set_deferred("monitoring", true)

func deactivate():
	falling_trigger.set_deferred("monitoring", false)

func _on_exit_teleported_entity(cause, entity):
	if not cause is EnemyDiamond:
		emit_signal("increase_floor")

func _on_falling_trigger_effect():
	emit_signal("decrease_floor")
