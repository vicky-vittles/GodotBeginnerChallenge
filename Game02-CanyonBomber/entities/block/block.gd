extends Area2D

signal destroyed(player_id, level)

const LEVEL_FRAMES = {
	1: 0,
	2: 1,
	3: 2,
	4: 3}
const MAX_LEVEL : int = 4

export (int) var level = 1
onready var down_ray = $DownRay
onready var destroyed_sfx = $destroyed_sfx
onready var animation_player = $AnimationPlayer
var destroyed : bool = false

func _ready():
	get_node("main").frame = LEVEL_FRAMES[level]

func set_level(new_level):
	level = new_level
	get_node("main").frame = LEVEL_FRAMES[level]

func _physics_process(delta):
	if not destroyed and not down_ray.is_colliding():
		get_node("shape").set_deferred("disabled", true)
		animation_player.play("fall_down")

func _on_area_entered(area):
	if area.is_in_group("bomb"):
		destroyed = true
		emit_signal("destroyed", area.player_id, level)
		get_node("shape").set_deferred("disabled", true)
		destroyed_sfx.play()
		animation_player.play("destroyed")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fall_down":
		get_node("shape").set_deferred("disabled", false)
		animation_player.play("default")
		global_position.y += 32
	elif anim_name == "destroyed":
		call_deferred("queue_free")
