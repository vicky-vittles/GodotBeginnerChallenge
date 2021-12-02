extends "res://entities/entity_player/scripts/states/ground/__player_ground_base_state.gd"

func enter(info: Dictionary = {}):
	entity.graphics_animation_player.play("blink")
	entity.invincibility_timer.start()
	entity.hurtbox.disable_all_shapes()

func exit():
	entity.hurtbox.enable_all_shapes()

func physics_process(delta):
	var move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(move_direction)
	entity.orient(move_direction)

func _on_InvincibilityTimer_timeout():
	if not fsm or not fsm.current_state:
		return
	if fsm.current_state == self:
		if get_move_direction() != 0:
			fsm.change_state("ground/walk")
		else:
			fsm.change_state("ground/idle")
