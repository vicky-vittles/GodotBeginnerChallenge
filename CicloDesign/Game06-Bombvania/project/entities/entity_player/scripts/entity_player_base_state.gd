extends "res://entities/__entity_topdown_player/scripts/entity_topdown_base_state.gd"

signal bomb_just_pressed()
signal remote_just_pressed()

export (bool) var can_place_bombs = false
export (bool) var can_detonate_bombs = false

func _on_Player_took_damage(damage):
	if fsm.current_state == self:
		entity.health.lose_health(damage)

func _on_bomb_just_pressed():
	if fsm.current_state == self and can_place_bombs:
		emit_signal("bomb_just_pressed")

func _on_remote_just_pressed():
	if fsm.current_state == self and can_detonate_bombs:
		emit_signal("remote_just_pressed")
