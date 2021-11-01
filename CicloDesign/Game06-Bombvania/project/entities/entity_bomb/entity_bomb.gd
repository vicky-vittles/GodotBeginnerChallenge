extends GTEntity2D

signal has_exploded()
signal exploded(bomb)

const ENTITY_PLAYER_BODY = "entity_player_body"
const FULL_COLLISION_MASK = 162

var power : int = 1
var fuse_time : float = 2.0 setget _set_fuse_time
var is_spike : bool = false
var is_remote : bool = false

onready var body = $Body
onready var fuse_timer = $Timers/FuseTimer
onready var graphics_animation_player = $Body/visuals/graphics/AnimationPlayer
onready var fuse_to_explode_transition = $StateMachine/Fuse/ToExplode

var tilemap

func fuse():
	if not is_remote:
		fuse_timer.start()
		graphics_animation_player.play("fuse")

func explode():
	fuse_to_explode_transition.do_transition()

func _set_fuse_time(_value):
	fuse_time = _value
	graphics_animation_player.playback_speed = 2.0 / fuse_time
	get_node("Timers/FuseTimer").wait_time = fuse_time

func _on_Explode_state_entered():
	emit_signal("exploded", self)
