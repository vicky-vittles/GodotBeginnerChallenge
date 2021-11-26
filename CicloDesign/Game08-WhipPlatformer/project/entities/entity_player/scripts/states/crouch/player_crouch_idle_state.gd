extends "res://entities/entity_player/scripts/states/crouch/__player_crouch_base_state.gd"

func enter(info: Dictionary = {}):
	entity.visuals_animation_player.play("crouch_idle")

func physics_process(delta):
	# Movement
	var move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(0)
	entity.orient(move_direction)
	if move_direction != 0:
		fsm.change_state("crouch/walk")
	
	if not entity.body.is_on_floor():
		fsm.change_state("air", {"starting_move_direction": move_direction})
	elif not get_crouch_pressed() and not get_head_raycasts_colliding():
		fsm.change_state("ground")
	elif get_attack_just_pressed():
		fsm.change_state("crouch/attack")
