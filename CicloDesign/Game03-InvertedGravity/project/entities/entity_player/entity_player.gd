extends "res://entities/__entity_platformer_player/__entity_platformer_player.gd"

signal inverted_gravity(direction)
signal died()

func _on_EntityMover_updated_gravity_mask(mask):
	emit_signal("inverted_gravity", mask) 

func _on_Dead_state_entered():
	emit_signal("died")
