extends "res://entities/__entity_topdown_player/states/entity_topdown_player_state.gd"

signal started_moving()
signal stopped_moving()
signal fire_just_pressed()

export (bool) var play_anim_on_enter = false
export (String) var anim_name = ""
export (bool) var _movement_change_state = true
export (bool) var _movement_equals_zero = true
export (String) var _movement_signal_name = ""
export (bool) var can_shoot = true

func _on_InputController_updated_move_direction(direction):
	if fsm.current_state != self:
		return
	actor.entity_mover.set_move_direction(direction)
	if _movement_equals_zero == (direction == Vector2.ZERO) and _movement_change_state:
		emit_signal(_movement_signal_name)

func _on_fire_just_pressed():
	if fsm.current_state == self and can_shoot:
		emit_signal("fire_just_pressed")
