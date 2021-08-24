extends Area

signal hurt()
signal take_damage(damage)

onready var damage_cooldown_timer = $DamageCooldownTimer

func hurt(damage: int, info):
	if damage_cooldown_timer.is_stopped():
		emit_signal("hurt")
		emit_signal("take_damage", damage)
