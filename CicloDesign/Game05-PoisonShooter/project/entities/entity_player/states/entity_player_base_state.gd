extends "res://entities/__entity_topdown_player/states/entity_topdown_base_state.gd"

signal fire_just_pressed()

func _on_fire_just_pressed():
	if fsm.current_state == self:
		emit_signal("fire_just_pressed")

func _on_Player_took_damage(damage):
	if fsm.current_state == self:
		entity.health.lose_health(damage)
