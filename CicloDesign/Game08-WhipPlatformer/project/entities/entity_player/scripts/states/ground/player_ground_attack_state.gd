extends "res://entities/entity_player/scripts/states/ground/__player_ground_base_state.gd"

const STR_UP = "_up"
const STR_DIAGONAL = "_diagonal"
const STR_SIDE = "_side"

export (bool) var can_turn_around = true

var move_direction : int

func enter(info: Dictionary = {}):
	# Decide on animation
	var anim_name = "ground_attack"
	var dir = entity.aim_direction
	if (sign(dir.x) != 0 and sign(dir.y) < 0):
		anim_name += STR_DIAGONAL
	elif (sign(dir.x) == 0 and sign(dir.y) < 0):
		anim_name += STR_UP
	else:
		anim_name += STR_SIDE
	
	move_direction = sign(dir.x)
	entity.animation_player.play(anim_name)
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
	if not fsm or not fsm.current_state:
		return
	if fsm.current_state == self:
		if get_move_direction() != 0:
			fsm.change_state("ground/walk")
		else:
			fsm.change_state("ground/idle")

func _on_whip_head_trigger_triggered_swing(point):
	if fsm and fsm.current_state == self:
		fsm.change_state("air", {"is_swinging": true, "swing_origin": point.global_position})
