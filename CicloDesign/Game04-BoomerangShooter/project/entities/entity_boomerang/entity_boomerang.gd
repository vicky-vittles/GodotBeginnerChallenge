extends GTEntity2D

signal caused_damage()
signal started_moving(direction)
signal collected(boomerang)

export (float) var rotation_speed = 1080.0
export (float) var initial_max_speed = 480.0
export (float) var max_returning_scaled_speed = 1080.0

onready var body = $Body
onready var rotation_pivot = $Body/graphics/rotation_pivot
onready var steering_entity_mover = $Body/SteeringEntityMover

var move_direction : Vector2
var returning_time_ellapsed : float = 0.0
var user_body setget _set_user_body
var is_returning : bool = false

func _set_user_body(_value):
	user_body = _value
	steering_entity_mover.set_target(user_body)

func _physics_process(delta):
	if is_returning:
		returning_time_ellapsed += delta
		steering_entity_mover.max_speed = clamp(initial_max_speed+returning_time_ellapsed*(max_returning_scaled_speed-initial_max_speed), initial_max_speed, max_returning_scaled_speed)
	rotation_pivot.rotation_degrees += rotation_speed*delta

func fire(_dir: Vector2):
	move_direction = _dir
	emit_signal("started_moving", _dir)

func _on_CatchTrigger_effect():
	emit_signal("collected", self)
	queue_free()

func _on_TurnaroundTimer_timeout():
	is_returning = true

func _on_DamageHitbox_effect():
	emit_signal("caused_damage")
