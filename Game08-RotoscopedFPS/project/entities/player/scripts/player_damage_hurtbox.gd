extends Area

signal take_damage(damage)

func hurt(damage: int):
	emit_signal("take_damage", damage)
