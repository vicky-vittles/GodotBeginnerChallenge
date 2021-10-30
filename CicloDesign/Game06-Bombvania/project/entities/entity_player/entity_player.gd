extends "res://entities/__entity_topdown_player/__entity_topdown_player.gd"

signal collected_heart()
signal collected_money(amount)
signal took_damage(damage)
signal died()

onready var health = $Stats/Health
onready var bomb_presence_trigger = $Body/Triggers/BombPresenceTrigger

var bombs = []

func _on_DamageHurtbox_took_damage(damage):
	emit_signal("took_damage", damage)

func _on_CollectibleTrigger_grouped_area_entered(area):
	match area.entity.collectible_type:
		Globals.COLLECTIBLE_TYPES.HEART:
			emit_signal("collected_heart")
		Globals.COLLECTIBLE_TYPES.MONEY_COIN:
			emit_signal("collected_money", Globals.MONEY_COIN)
		Globals.COLLECTIBLE_TYPES.MONEY_DIAMOND:
			emit_signal("collected_money", Globals.MONEY_DIAMOND)
