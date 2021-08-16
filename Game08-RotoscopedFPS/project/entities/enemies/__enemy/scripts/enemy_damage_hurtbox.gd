extends Area

signal hurt()
signal take_damage(damage, info)

func hurt(damage, info):
	emit_signal("hurt")
	emit_signal("take_damage", damage, info)
