extends "res://entities/entity_enemy/scripts/states/__enemy_base_state.gd"

func enter(info: Dictionary = {}):
	entity.animation_player.play("fall")

func physics_process(delta):
	# Movement
	var move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(move_direction)
	entity.orient(move_direction)
	
	# Transitions
	if entity.body.is_on_floor():
		entity.entity_mover.land()
		if move_direction == 0:
			fsm.change_state("idle")
		else:
			fsm.change_state("walk")
