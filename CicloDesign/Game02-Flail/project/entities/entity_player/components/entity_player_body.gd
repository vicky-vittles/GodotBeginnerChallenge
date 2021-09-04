extends KinematicBody2D

signal updated_slower_velocity()
signal updated_faster_velocity()

export (NodePath) var actor_path
onready var actor = get_node(actor_path)

var slow_speed : bool = true

func _on_EntityMover_velocity_updated(velocity):
	var current_slow_speed = velocity.length() < actor.min_speed_for_damage
	if current_slow_speed and not slow_speed:
		slow_speed = true
		emit_signal("updated_slower_velocity")
	if not current_slow_speed and slow_speed:
		slow_speed = false
		emit_signal("updated_faster_velocity")
