extends Node
class_name GTCurrency

signal amount_updated(current)
signal amount_gained(current, gained)
signal amount_lost(current, lost)

export (int) var initial_amount = 0

onready var current_amount = initial_amount

func gain_amount(amount: int) -> void:
	current_amount += amount
	emit_signal("amount_updated", current_amount)
	emit_signal("amount_gained", current_amount, amount)

func lose_amount(amount: int) -> void:
	current_amount -= amount
	emit_signal("amount_updated", current_amount)
	emit_signal("amount_lost", current_amount, amount)

func set_amount(amount: int) -> void:
	current_amount = amount
	emit_signal("amount_updated", current_amount)
