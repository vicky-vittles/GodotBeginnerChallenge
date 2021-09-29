extends Node2D
class_name GTJuice2D

export (bool) var is_active = true

var tween : Tween

func _ready():
	tween = Tween.new()
	add_child(tween)
	tween.name = "_Tween"

func simple_squash_stretch(strength: float = 0.3, time: float = 0.15):
	if not is_active: return
	tween.interpolate_property(self, "scale", Vector2.ONE, Vector2(1+strength,1-strength), time/3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "scale", Vector2(1+strength,1-strength), Vector2(1-strength,1+strength), time/3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, time/3)
	tween.interpolate_property(self, "scale", Vector2(1-strength,1+strength), Vector2.ONE, time/3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 2*time/3)
	tween.start()

func squash_stretch(strength: float = 0.45, time: float = 0.2):
	if not is_active: return
	tween.interpolate_property(self, "scale", Vector2.ONE, Vector2(1+strength,1-strength), time/3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(self, "scale", Vector2(1+strength,1-strength), Vector2(1-strength,1+strength), time/3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, time/5)
	tween.interpolate_property(self, "scale", Vector2(1-strength,1+strength), Vector2(1+strength/2,1-strength/2), time/3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 2*time/5)
	tween.interpolate_property(self, "scale", Vector2(1+strength/2,1-strength/2), Vector2(1-strength/2,1+strength/2), time/3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 3*time/5)
	tween.interpolate_property(self, "scale", Vector2(1-strength/2,1+strength/2), Vector2.ONE, time/3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 4*time/5)
	tween.start()

func simple_scale(start_size: Vector2 = Vector2.ONE, end_size: Vector2 = Vector2(1.2, 1.2), time: float = 0.3):
	if not is_active: return
	tween.interpolate_property(self, "scale", start_size, end_size, time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func simple_rotate(amplitude: float = 5.0, time: float = 0.15):
	if not is_active: return
	tween.interpolate_property(self, "rotation_degrees", rotation_degrees, amplitude, time, Tween.TRANS_QUAD, Tween.EASE_IN)
	tween.start()

func simple_float(amplitude: float = 16.0, time: float = 1.0, delay: float = 0.0):
	if not is_active: return
	tween.interpolate_property(self, "position", Vector2.ZERO, Vector2.UP*amplitude, time, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, delay)
	tween.interpolate_property(self, "position", Vector2.UP*amplitude, Vector2.ZERO, time, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT, 1.0 + delay)
	tween.start()
