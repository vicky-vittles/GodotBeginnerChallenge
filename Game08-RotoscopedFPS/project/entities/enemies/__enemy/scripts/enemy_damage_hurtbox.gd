extends Area

signal take_damage(damage, info)

func hurt(damage, info):
	emit_signal("take_damage", damage, info)
