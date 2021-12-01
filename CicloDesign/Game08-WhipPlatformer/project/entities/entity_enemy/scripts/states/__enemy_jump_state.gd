extends "res://entities/entity_enemy/scripts/states/__enemy_base_state.gd"

func enter(info: Dictionary = {}):
	entity.entity_mover.jump()
	entity.animation_player.play("jump")

func physics_process(delta):
	# Movement
	var move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(move_direction)
	entity.orient(move_direction)
	
	# Transitions
	if entity.entity_mover.velocity.y > 0:
		fsm.change_state("fall")
