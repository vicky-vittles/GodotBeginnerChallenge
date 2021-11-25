extends "res://entities/entity_player/scripts/states/__player_base_state.gd"

signal started_moving()
signal stopped_moving()
signal started_attacking()

export (bool) var can_move = false
export (bool) var can_attack = false

func physics_process(delta):
	# Movement
	var move_direction = get_move_direction()
	if move_direction != 0 and can_move:
		entity.entity_mover.set_move_direction(move_direction)
		emit_signal("started_moving")
	else:
		entity.entity_mover.set_move_direction(0)
		emit_signal("stopped_moving")
	
	if not entity.body.is_on_floor():
		fsm.change_state("air")
	elif not get_crouch_pressed() and not get_head_raycasts_colliding():
		fsm.change_state("ground")
	elif get_attack_just_pressed() and can_attack:
		fsm.change_state("crouch/attack")

func get_head_raycasts_colliding():
	for raycast in entity.head_raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false
