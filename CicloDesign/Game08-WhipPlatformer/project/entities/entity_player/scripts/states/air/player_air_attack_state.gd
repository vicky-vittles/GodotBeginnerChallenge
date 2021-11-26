extends "res://entities/entity_player/scripts/states/air/__player_air_base_state.gd"

const STR_UP = "_up"
const STR_DIAGONAL_UP = "_diagonal_up"
const STR_SIDE = "_side"
const STR_DIAGONAL_DOWN = "_diagonal_down"
const STR_DOWN = "_down"

export (float) var aim_direction_delay = 0.2
export (bool) var can_move = true

var aim_direction_delay_timer : Timer
var starting_move_direction : int

func _ready():
	aim_direction_delay_timer = Timer.new()
	aim_direction_delay_timer.one_shot = true
	aim_direction_delay_timer.wait_time = aim_direction_delay
	aim_direction_delay_timer.name = "_AimDirectionDelayTimer"
	add_child(aim_direction_delay_timer)
	aim_direction_delay_timer.connect("timeout", self, "_on_Timer_timeout")

func enter(info: Dictionary = {}):
	if info.has("starting_move_direction"):
		starting_move_direction = info["starting_move_direction"]
	else:
		starting_move_direction = get_move_direction()
	var anim_name = decide_aim_direction(entity.aim_direction)
	
	entity.visuals_animation_player.play(anim_name)
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
	var move_direction = starting_move_direction
	if can_move:
		move_direction = get_move_direction()
	entity.entity_mover.set_move_direction(move_direction)
	entity.orient(move_direction)
	
	# Transitions
	if entity.body.is_on_floor():
		entity.entity_mover.land()
		fsm.change_state("ground")

func _on_Timer_timeout():
	var anim_name = decide_aim_direction(entity.aim_direction)
	var anim_seconds = entity.visuals_animation_player.current_animation_position
	entity.visuals_animation_player.play(anim_name)
	entity.visuals_animation_player.seek(anim_seconds, true)

func _on_AttackTimer_timeout():
	if fsm and fsm.current_state == self:
		fsm.change_state("air/fall", {"starting_move_direction": starting_move_direction})

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
