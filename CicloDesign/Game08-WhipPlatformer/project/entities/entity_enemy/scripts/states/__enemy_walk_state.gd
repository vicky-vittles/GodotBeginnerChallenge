extends "res://entities/entity_enemy/scripts/states/__enemy_base_state.gd"

var move_direction : int

func enter(info: Dictionary = {}):
	move_direction = info["move_direction"]
	entity.animation_player.play("walk")

func physics_process(delta):
	# Movement
	move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(move_direction)
	entity.orient(move_direction)
	if move_direction == 0:
		fsm.change_state("idle")
	
	# Transitions
	if not entity.body.is_on_floor():
		fsm.change_state("fall")
	elif get_jump_just_pressed():
		fsm.change_state("jump")
