extends "res://entities/entity_player/scripts/states/__player_base_state.gd"

func take_damage(damage):
	if not fsm or not fsm.current_state:
		return
	if fsm.current_state == self:
		entity.health.lose_health(damage)
		fsm.change_state("ground/hurt")
