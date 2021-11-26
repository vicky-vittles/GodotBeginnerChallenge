extends "res://entities/entity_player/scripts/states/air/__player_air_base_state.gd"

export (float) var attack_cooldown_time = 0.1

var attack_cooldown : float = 0.0
var perform_attack : bool = false

func enter(info: Dictionary = {}):
	starting_move_direction = get_move_direction()
	entity.visuals_animation_player.play("air_jump")
	entity.entity_mover.jump()
	attack_cooldown = attack_cooldown_time

func physics_process(delta):
	var move_direction = starting_move_direction
	if can_move:
		move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(move_direction)
	entity.orient(move_direction)
	
	# Attack
	attack_cooldown -= delta
	if attack_cooldown > 0 and get_attack_just_pressed():
		perform_attack = true
	if attack_cooldown <= 0:
		if perform_attack:
			fsm.change_state("air/attack", {"starting_move_direction": starting_move_direction})
		perform_attack = get_attack_just_pressed()
	
	if entity.entity_mover.velocity.y > 0:
		fsm.change_state("air/fall", {"starting_move_direction": starting_move_direction})
