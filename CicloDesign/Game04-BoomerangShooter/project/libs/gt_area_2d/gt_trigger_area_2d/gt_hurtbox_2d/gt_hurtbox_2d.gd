extends GTTriggerArea2D
class_name GTHurtbox2D

signal took_damage(damage)

func _ready():
	connect("grouped_area_entered", self, "take_damage")

func take_damage(area):
	var damage = area.damage
	emit_signal("took_damage", damage)
