extends Node
class_name GTHealth

signal health_updated(current)
signal health_gained(current, gained)
signal health_lost(current, lost)
signal died(current)

export (int) var max_health = 100
export (int) var initial_health = 100
export (bool) var deactivate_upon_death = false

var is_alive : bool = true
onready var current_health = initial_health

func gain_health(amount: int) -> void:
	if deactivate_upon_death and not is_alive:
		return
	current_health += amount
	current_health = clamp(current_health, current_health, max_health)
	emit_signal("health_updated", current_health)
	emit_signal("health_gained", current_health, amount)

func lose_health(amount: int) -> void:
	if deactivate_upon_death and not is_alive:
		return
	current_health -= amount
	current_health = clamp(current_health, current_health, max_health)
	
	if current_health <= 0:
		is_alive = false
		emit_signal("died", current_health)
	
	emit_signal("health_updated", current_health)
	emit_signal("health_lost", current_health, amount)
