extends ScreenTransition

const OPAQUE = Color(1.0, 1.0, 1.0, 1.0)
const TRANSPARENT = Color(1.0, 1.0, 1.0, 0.0)

func enter():
	screen.visible = true
	tween.interpolate_property(screen, "modulate", TRANSPARENT, OPAQUE, anim_time)
	tween.start()

func exit():
	tween.interpolate_property(screen, "modulate", OPAQUE, TRANSPARENT, anim_time)
	tween.start()
	v_timer.start()
