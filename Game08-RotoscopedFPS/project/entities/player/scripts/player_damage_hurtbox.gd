extends Area

signal hurt()
signal take_damage(damage)

func hurt(damage: int, info):
	emit_signal("hurt")
	emit_signal("take_damage", damage)
