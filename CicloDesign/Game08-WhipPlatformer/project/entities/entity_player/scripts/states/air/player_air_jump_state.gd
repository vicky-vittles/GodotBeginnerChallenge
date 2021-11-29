extends "res://entities/entity_player/scripts/states/air/__player_air_base_state.gd"

export (float) var attack_cooldown_time = 0.1 # Time before can attack
export (float) var hang_time = 0.05

var attack_cooldown : float = 0.0
var hang_timer : float = 0.0

var perform_attack : bool = false # Flag to perform attack or not
var damped_jump : bool = false # Flag to check if player already released jump button
var started_hanging : bool = false # Flag to check if player starting falling and should start hanging instead

func enter(info: Dictionary = {}):
	entity.entity_mover.jump()
	attack_cooldown = attack_cooldown_time
	hang_timer = hang_time
	perform_attack = false
	started_hanging = false
	damped_jump = false
	entity.animation_player.play("air_jump")

func physics_process(delta):
	# Movement
	var move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(move_direction)
	entity.orient(move_direction)
	
	if not damped_jump and get_jump_just_released():
		entity.entity_mover.damp_jump()
	
	# Hang time
	if entity.entity_mover.velocity.y >= 0:
		started_hanging = true
	if started_hanging:
		hang_timer -= delta
		if hang_timer > 0.0:
			entity.entity_mover.velocity.y = 0
	
	# Attack
	attack_cooldown -= delta
	var performed_attack = false
	if attack_cooldown > 0 and get_attack_just_pressed():
		perform_attack = true
	if attack_cooldown <= 0:
		if perform_attack:
			fsm.change_state("air/attack", {"started_hanging": started_hanging})
			performed_attack = true
		perform_attack = get_attack_just_pressed()
	
	# Transitions
	if not performed_attack and hang_timer < 0.0 and entity.entity_mover.velocity.y > 0:
		fsm.change_state("air/fall")
