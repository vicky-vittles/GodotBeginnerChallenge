extends Area

signal take_damage(damage)

func hurt(damage):
	emit_signal("take_damage", damage)
