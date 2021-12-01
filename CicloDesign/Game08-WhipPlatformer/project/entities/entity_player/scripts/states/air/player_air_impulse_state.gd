extends "res://entities/entity_player/scripts/states/air/__player_air_base_state.gd"

export (float) var impulse_time = 0.15

var entity_mover : Node
var impulse_mover : Node

var impulse_timer : float = 0.0
var impulse_direction : Vector2

func enter(info: Dictionary = {}):
	if info.has("impulse_direction"):
		impulse_direction = info["impulse_direction"]
	entity_mover = entity.entity_mover
	impulse_mover = entity.impulse_entity_mover
	impulse_timer = impulse_time
	
	entity_mover.disable()
	entity_mover.set_velocity(Vector2.ZERO)
	impulse_mover.enable()
	impulse_mover.set_move_direction(impulse_direction)

func exit():
	entity_mover.enable()
	entity_mover.restore_jumps()
	entity_mover.set_velocity(impulse_mover.velocity)
	entity_mover.set_walk_mode(2)
	impulse_mover.disable()
	impulse_mover.set_move_direction(Vector2.ZERO)

func physics_process(delta):
	impulse_timer -= delta
	if impulse_timer < 0.0:
		fsm.change_state("air/fall")
