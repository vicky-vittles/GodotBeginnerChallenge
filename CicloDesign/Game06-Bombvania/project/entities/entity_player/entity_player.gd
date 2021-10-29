extends "res://entities/__entity_topdown_player/__entity_topdown_player.gd"

signal took_damage(damage)
signal died()

onready var health = $Health
onready var bomb_presence_trigger = $Body/Triggers/BombPresenceTrigger

var bombs = []

func _on_DamageHurtbox_took_damage(damage):
	emit_signal("took_damage", damage)
