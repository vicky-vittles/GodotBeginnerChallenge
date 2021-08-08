extends Area

signal take_damage(damage)

func hurt(damage: int, info):
	emit_signal("take_damage", damage)
