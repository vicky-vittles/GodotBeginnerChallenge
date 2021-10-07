extends GTTriggerArea2D
class_name GTHitbox2D

signal caused_damage(damage)

export (int) var damage

func _ready():
	connect("effect", self, "cause_damage")

func cause_damage():
	emit_signal("caused_damage", damage)
