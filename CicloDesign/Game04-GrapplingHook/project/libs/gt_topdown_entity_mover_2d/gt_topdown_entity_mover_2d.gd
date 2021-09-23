extends Node
class_name GTTopdownEntityMover2D

signal position_updated(pos)
signal collided(result)

export (NodePath) var body_path
onready var body = get_node(body_path)

export (int) var MAX_MOVE_SPEED = 256
export (float) var MOVE_ACCELERATION = 0.2
export (float) var MOVE_DECELERATION = 0.2

export (Vector2) var movement_mask = Vector2(1, 1)
export (bool) var frozen = false
export (bool) var is_enabled = true

var move_direction : Vector2
var velocity : Vector2
var acceleration : float

func _ready():
	assert(body != null, "%s has no body set" % [self.name])

func set_move_direction(_dir: Vector2):
	move_direction = _dir

func move(delta):
	if frozen or not is_enabled:
		return
	if move_direction != Vector2.ZERO:
		velocity = lerp(velocity, MAX_MOVE_SPEED * move_direction, MOVE_ACCELERATION)
	else:
		velocity = lerp(velocity, Vector2.ZERO, MOVE_DECELERATION)
	velocity = velocity.clamped(MAX_MOVE_SPEED)
	velocity *= movement_mask
	var collision = body.move_and_collide(velocity * delta)
	if collision:
		emit_signal("collided", collision)
	emit_signal("position_updated", body.global_position)

func set_movement_mask(_mask) -> void:
	movement_mask = _mask

func freeze(preserve_momentum: bool = true):
	if not preserve_momentum:
		velocity = Vector2.ZERO
	frozen = true

func unfreeze():
	frozen = false

func enable():
	is_enabled = true

func disable():
	is_enabled = false
