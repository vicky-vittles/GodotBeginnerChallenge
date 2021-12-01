extends "res://entities/entity_enemy/scripts/states/__enemy_base_state.gd"

func enter(info: Dictionary = {}):
	entity.animation_player.play("idle")

func physics_process(delta):
	# Movement
	var move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(0)
	entity.orient(move_direction)
	if move_direction != 0:
		fsm.change_state("walk", {"move_direction": move_direction})
	
	# Transitions
	if not entity.body.is_on_floor():
		fsm.change_state("fall")
	elif get_jump_just_pressed():
		fsm.change_state("jump")
