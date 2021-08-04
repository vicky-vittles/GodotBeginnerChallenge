extends GTState

onready var SHOOTING = $"../Shooting"

func _on_weapon_pressed_shoot():
	if fsm.current_state == self:
		fsm.change_state(SHOOTING)
