extends "res://entities/entity_player/scripts/states/air/__player_air_base_state.gd"

export (float) var attack_cooldown_time = 0.1

var attack_cooldown : float = 0.0
var perform_attack : bool = false

func enter(info: Dictionary = {}):
	entity.animation_player.play("air_jump")
	entity.entity_mover.jump()
	attack_cooldown = attack_cooldown_time

func physics_process(delta):
	movement()
	
	# Attack
	if can_attack:
		attack_cooldown -= delta
		if attack_cooldown > 0 and get_attack_just_pressed():
			perform_attack = true
		if attack_cooldown <= 0:
			if perform_attack:
				fsm.change_state("air/attack")
			perform_attack = get_attack_just_pressed()
	
	if entity.entity_mover.velocity.y > 0:
		fsm.change_state("air/fall")
