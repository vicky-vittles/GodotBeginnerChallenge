extends "res://entities/entity_player/scripts/states/__player_base_state.gd"

signal started_moving()
signal stopped_moving()
signal started_attacking()

export (float) var grounded_buffer_time = 0.05

export (bool) var can_move = false
export (bool) var can_jump = false
export (bool) var can_fall = true
export (bool) var can_attack = false
export (bool) var can_crouch = false

var grounded_timer : float = 0.0

func physics_process(delta):
	# Movement
	var move_direction = get_move_direction()
	if move_direction != 0 and can_move:
		entity.entity_mover.set_move_direction(move_direction)
		emit_signal("started_moving")
	else:
		entity.entity_mover.set_move_direction(0)
		emit_signal("stopped_moving")
	
	# Grounded time after falling from floor
	grounded_timer -= delta
	if entity.body.is_on_floor():
		grounded_timer = grounded_buffer_time
	
	if grounded_timer <= 0 and not entity.body.is_on_floor() and can_fall:
		fsm.change_state("air")
	elif get_attack_just_pressed() and can_attack:
		fsm.change_state("ground/attack")
	elif get_jump_just_pressed() and can_jump:
		fsm.change_state("air", {"is_jumping": true})
	elif get_crouch_pressed() and can_crouch:
		fsm.change_state("crouch")
	
