extends "res://entities/entity_player/scripts/states/ground/__player_ground_base_state.gd"

const STR_UP = "_up"
const STR_DIAGONAL = "_diagonal"
const STR_SIDE = "_side"

func enter(info: Dictionary = {}):
	var anim_name = "ground_attack"
	var dir = entity.aim_direction
	if (sign(dir.x) != 0 and sign(dir.y) < 0):
		anim_name += STR_DIAGONAL
	elif (sign(dir.x) == 0 and sign(dir.y) < 0):
		anim_name += STR_UP
	else:
		anim_name += STR_SIDE
	entity.visuals_animation_player.play(anim_name)
	entity.attack_timer.start()

func exit():
	entity.whip_sprite.visible = false
	entity.attack_timer.stop()

func _on_AttackTimer_timeout():
	if fsm and fsm.current_state == self:
		if get_move_direction() != 0:
			fsm.change_state("ground/walk")
		else:
			fsm.change_state("ground/idle")
