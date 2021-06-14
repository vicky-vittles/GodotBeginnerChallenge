extends TextureProgress

const ANIM_TIME = 0.5
onready var tween = $Tween
onready var animated_value = max_value

func _on_Health_health_updated(current):
	tween.interpolate_property(self, "animated_value", animated_value, current, ANIM_TIME)
	tween.start()

func _process(delta):
	value = animated_value
