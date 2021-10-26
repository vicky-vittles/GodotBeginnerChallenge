extends GTEntity2D

signal shot()
signal exploded()

export (float) var min_scale = 0.5
export (float) var max_scale = 1.5
export (float) var fuse_time = 1.0 setget _set_fuse_time

onready var fuse_timer = $Timers/FuseTimer
onready var body = $Body
onready var graphics = $Body/visuals/graphics
onready var entity_mover = $Body/EntityMover
onready var tween = $Tween

func shoot(direction: Vector2):
	#tween.interpolate_property(graphics, "scale", max_scale*Vector2.ONE, min_scale*Vector2.ONE, fuse_time)
	#tween.start()
	entity_mover.set_velocity(direction*entity_mover.max_move_speed)
	emit_signal("shot")

func explode():
	emit_signal("exploded", self)

func _set_fuse_time(_value): get_node("Timers/FuseTimer").wait_time = fuse_time
