extends "res://entities/entity_player/states/__entity_player_state.gd"

signal took_damage()

func physics_process(delta):
	.physics_process(delta)


func _on_DamageHurtbox_effect():
	if fsm.current_state == self:
		emit_signal("took_damage")
