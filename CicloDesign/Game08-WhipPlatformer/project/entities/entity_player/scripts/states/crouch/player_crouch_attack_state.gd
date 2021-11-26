extends "res://entities/entity_player/scripts/states/crouch/__player_crouch_base_state.gd"

export (bool) var can_turn_around = true

var move_direction : int

func enter(info: Dictionary = {}):
	var anim_name = "crouch_attack_side"
	var dir = entity.aim_direction
	move_direction = sign(dir.x)
	
	entity.visuals_animation_player.play(anim_name)
	entity.attack_timer.start()
	entity.whip_head_trigger.enable_all_shapes()

func exit():
	entity.whip_sprite.visible = false
	entity.attack_timer.stop()
	entity.whip_head_trigger.disable_all_shapes()

func physics_process(delta):
	# Movement
	if can_turn_around:
		move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(0)
	entity.orient(move_direction)
	
	# Transitions
	if not entity.body.is_on_floor():
		fsm.change_state("air")

func _on_AttackTimer_timeout():
	if fsm and fsm.current_state == self:
		if get_move_direction() != 0:
			fsm.change_state("crouch/walk")
		else:
			fsm.change_state("crouch/idle")
