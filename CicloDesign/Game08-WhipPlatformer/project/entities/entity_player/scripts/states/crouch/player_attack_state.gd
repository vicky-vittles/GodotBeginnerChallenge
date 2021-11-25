extends "res://entities/entity_player/scripts/states/crouch/__player_crouch_base_state.gd"

func enter(info: Dictionary = {}):
	var anim_name = "crouch_attack_side"
	var dir = entity.aim_direction
	entity.visuals_animation_player.play(anim_name)
	entity.attack_timer.start()

func exit():
	entity.whip_sprite.visible = false
	entity.attack_timer.stop()

func _on_AttackTimer_timeout():
	if fsm and fsm.current_state == self:
		if get_move_direction() != 0:
			fsm.change_state("crouch/walk")
		else:
			fsm.change_state("crouch/idle")
