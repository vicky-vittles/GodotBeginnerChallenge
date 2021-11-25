extends "res://entities/entity_player/scripts/states/__player_base_state.gd"

export (bool) var can_move = false
export (bool) var can_attack = false

func movement():
	var move_direction = get_move_direction()
	if move_direction != 0 and can_move:
		entity.entity_mover.set_move_direction(move_direction)
	else:
		entity.entity_mover.set_move_direction(0)

func attack():
	var attack_just_pressed = get_attack_just_pressed()
	if attack_just_pressed and can_attack:
		fsm.change_state("air/attack")
