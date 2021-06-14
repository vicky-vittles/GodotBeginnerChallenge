extends Area2D

signal entered_explosion(damage)

func _on_area_entered(area):
	if area.is_in_group("explosion"):
		var damage = area.explosion.MAX_DAMAGE
		emit_signal("entered_explosion", damage)
