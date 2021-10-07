extends EntityTopdownPlayer

enum CATCH_MODE {
	DEFAULT,
	EASY}
export (CATCH_MODE) var catch_mode = CATCH_MODE.DEFAULT

onready var catch_timer = $Timers/CatchTimer

var aim_direction : Vector2
