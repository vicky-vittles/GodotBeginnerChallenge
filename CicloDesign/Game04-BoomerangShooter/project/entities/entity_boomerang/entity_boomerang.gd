extends GTEntity2D

signal started_moving(direction)
signal collected(boomerang)

export (float) var rotation_speed = 1080.0

onready var body = $Body
onready var rotation_pivot = $Body/graphics/rotation_pivot
onready var steering_entity_mover = $Body/SteeringEntityMover

var move_direction : Vector2
var user_body setget _set_user_body

func _set_user_body(_value):
	user_body = _value
	steering_entity_mover.set_target(user_body)

func _physics_process(delta):
	rotation_pivot.rotation_degrees += rotation_speed*delta

func fire(_dir: Vector2):
	move_direction = _dir
	emit_signal("started_moving", _dir)

func _on_CatchTrigger_effect():
	emit_signal("collected", self)
	queue_free()
