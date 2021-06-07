extends ScreenTransition

const INITIAL_POS = Vector2(0, 0)
const FINAL_POS = Vector2(2000, 0)

func enter():
	screen.visible = true
	tween.interpolate_property(screen, "rect_position", -FINAL_POS, INITIAL_POS, anim_time)
	tween.start()

func exit():
	tween.interpolate_property(screen, "rect_position", INITIAL_POS, FINAL_POS, anim_time)
	tween.start()
	v_timer.start()
