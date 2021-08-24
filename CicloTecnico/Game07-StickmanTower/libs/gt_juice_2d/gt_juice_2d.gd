extends Node2D
class_name GTJuice2D

var tween : Tween

func _ready():
	var sprites_num = 0
	for child in get_children():
		if child is Sprite:
			sprites_num += 1
	assert(sprites_num > 0, "%s (%s) has no Sprite child. Please add a Sprite child." % [self.name, self])
	tween = Tween.new()
	add_child(tween)
	tween.name = "_Tween"

func jump(strength: float = 0.3, time: float = 0.15):
	tween.interpolate_property(self, "scale", Vector2.ONE, Vector2(1+strength,1-strength), time/3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "scale", Vector2(1+strength,1-strength), Vector2(1-strength,1+strength), time/3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, time/3)
	tween.interpolate_property(self, "scale", Vector2(1-strength,1+strength), Vector2.ONE, time/3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 2*time/3)
	tween.start()
