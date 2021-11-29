extends "res://entities/entity_player/scripts/states/air/__player_air_base_state.gd"

const STR_UP = "_up"
const STR_DIAGONAL_UP = "_diagonal_up"
const STR_SIDE = "_side"
const STR_DIAGONAL_DOWN = "_diagonal_down"
const STR_DOWN = "_down"

export (float) var aim_direction_delay = 0.2
export (float) var hang_time = 0.05

var aim_direction_delay_timer : Timer
var hang_timer : float = 0.0
var started_hanging : bool = false # Flag to check if player starting falling and should start hanging instead

func _ready():
	aim_direction_delay_timer = Timer.new()
	aim_direction_delay_timer.one_shot = true
	aim_direction_delay_timer.wait_time = aim_direction_delay
	aim_direction_delay_timer.name = "_AimDirectionDelayTimer"
	add_child(aim_direction_delay_timer)
	aim_direction_delay_timer.connect("timeout", self, "_on_Timer_timeout")

func enter(info: Dictionary = {}):
	if info.has("started_hanging"):
		started_hanging = info["started_hanging"]
	else:
		started_hanging = false
	hang_timer = hang_time
	
	var anim_name = decide_aim_direction(entity.aim_direction)
	entity.animation_player.play(anim_name)
	entity.attack_timer.start()
	entity.whip_head_trigger.enable_all_shapes()
	aim_direction_delay_timer.start()

func exit():
	entity.whip_sprite.visible = false
	entity.attack_timer.stop()
	entity.whip_head_trigger.disable_all_shapes()
	aim_direction_delay_timer.stop()

func physics_process(delta):
	# Movement
	var move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(move_direction)
	entity.orient(move_direction)
	
	# Hang time
	if not started_hanging:
		hang_timer -= delta
		if hang_timer > 0.0:
			entity.entity_mover.velocity.y = 0
	
	# Transitions
	if entity.body.is_on_floor():
		entity.entity_mover.land()
		fsm.change_state("ground")

func _on_Timer_timeout():
	var anim_name = decide_aim_direction(entity.aim_direction)
	var anim_seconds = entity.animation_player.current_animation_position
	entity.animation_player.play(anim_name)
	entity.animation_player.seek(anim_seconds, true)

func _on_AttackTimer_timeout():
	if fsm and fsm.current_state == self:
		fsm.change_state("air/fall")

func _on_whip_head_trigger_triggered_swing(point):
	if fsm and fsm.current_state == self:
		fsm.change_state("air/swing", {"swing_origin": point.global_position})

func decide_aim_direction(dir) -> String:
	var anim_name = "air_attack"
	if sign(dir.x) == 0 and sign (dir.y) < 0:
		anim_name += STR_UP
	elif sign(dir.x) == 0 and sign(dir.y) > 0:
		anim_name += STR_DOWN
	elif sign(dir.x) != 0 and sign(dir.y) < 0:
		anim_name += STR_DIAGONAL_UP
	elif sign(dir.x) != 0 and sign(dir.y) > 0:
		anim_name += STR_DIAGONAL_DOWN
	else:
		anim_name += STR_SIDE
	return anim_name
