extends "res://entities/entity_player/scripts/states/air/__player_air_base_state.gd"

export (float) var attack_cooldown_time = 0.1
export (bool) var can_move = true

var attack_cooldown : float = 0.0
var perform_attack : bool = false
var starting_move_direction : int

func enter(info: Dictionary = {}):
	entity.entity_mover.jump()
	starting_move_direction = get_move_direction()
	attack_cooldown = attack_cooldown_time
	entity.animation_player.play("air_jump")

func physics_process(delta):
	# Movement
	var move_direction = starting_move_direction
	if can_move:
		move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(move_direction)
	entity.orient(move_direction)
	
	# Attack
	var performed_attack = false
	attack_cooldown -= delta
	if attack_cooldown > 0 and get_attack_just_pressed():
		perform_attack = true
	if attack_cooldown <= 0:
		if perform_attack:
			fsm.change_state("air/attack", {"starting_move_direction": starting_move_direction})
			performed_attack = true
		perform_attack = get_attack_just_pressed()
	
	# Transitions
	if not performed_attack and entity.entity_mover.velocity.y > 0:
		fsm.change_state("air/fall", {"starting_move_direction": starting_move_direction})
