extends GTState

signal started_moving()
signal stopped_moving()
signal fired_shot()

export (bool) var can_move = true
export (bool) var can_shoot = true

func _on_InputController_updated_move_direction(direction):
	if fsm.current_state != self:
		return
	if can_move:
		entity.entity_mover.set_move_direction(direction)
		if direction == Vector2.ZERO:
			emit_signal("stopped_moving")
		else:
			emit_signal("started_moving")
	else:
		entity.entity_mover.set_move_direction(Vector2.ZERO)

func _on_shoot_just_pressed():
	if fsm.current_state != self:
		return
	if not entity.weapon_fire_torrent and can_shoot:
		entity.weapon.shoot(entity.aim_direction)
		emit_signal("fired_shot")

func _on_shoot_pressed():
	if fsm.current_state != self:
		return
	if entity.weapon_fire_torrent and can_shoot:
		entity.weapon.shoot(entity.aim_direction)
		emit_signal("fired_shot")
