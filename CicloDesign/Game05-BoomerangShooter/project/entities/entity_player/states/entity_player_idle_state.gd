extends "res://entities/__entity_topdown_player/states/entity_topdown_player_state.gd"

signal started_moving()
signal fire_just_pressed()
signal fired_boomerang(direction)
signal released_boomerang()

func _on_InputController_updated_move_direction(direction):
	if fsm.current_state != self:
		return
	actor.body.entity_mover.set_move_direction(direction)
	if direction != Vector2.ZERO:
		emit_signal("started_moving")

func _on_fire_just_pressed():
	if fsm.current_state == self:
		if actor.catch_timer.is_stopped():
			emit_signal("fire_just_pressed")
		emit_signal("fired_boomerang", actor.aim_direction)

func _on_fire_just_released():
	if fsm.current_state == self:
		emit_signal("released_boomerang")
