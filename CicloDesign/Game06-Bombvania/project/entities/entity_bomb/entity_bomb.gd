extends GTEntity2D

signal exploded()

var power : int = 1 setget _set_power
var fuse_time : float = 2.0 setget _set_fuse_time
var is_remote : bool = false setget _set_is_remote

onready var graphics_animation_player = $Body/visuals/graphics/AnimationPlayer

func _set_power(_value):
	power = _value

func _set_fuse_time(_value):
	fuse_time = _value
	graphics_animation_player.playback_speed = 2.0 / fuse_time
	get_node("Timers/FuseTimer").wait_time = fuse_time

func _set_is_remote(_value):
	is_remote = _value
