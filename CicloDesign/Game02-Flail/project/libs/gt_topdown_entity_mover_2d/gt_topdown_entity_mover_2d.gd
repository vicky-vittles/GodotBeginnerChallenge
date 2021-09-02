extends Node
class_name GTTopdownEntityMover2D

signal position_updated(position)
signal velocity_updated(velocity)

export (NodePath) var body_path
onready var body = get_node(body_path)

export (int) var MAX_SPEED = 128
export (float) var TIME_TO_MAX_SPEED = 0.5
export (float) var TIME_TO_ZERO_SPEED = 2.0
onready var MOVE_ACCELERATION = MAX_SPEED / TIME_TO_MAX_SPEED
onready var MOVE_DECELERATION = MAX_SPEED / TIME_TO_ZERO_SPEED

export (float) var bounce = 0.0

export (Vector2) var movement_mask = Vector2(1, 1)
export (bool) var frozen = false

var move_direction : Vector2
var acceleration : Vector2
var velocity : Vector2

func _ready():
	assert(body != null, "%s has no body set" % [self.name])

func set_move_direction(_dir: Vector2):
	move_direction = _dir

func move(delta):
	if frozen:
		return
	
	# Set correct acceleration
	acceleration = move_direction * MOVE_ACCELERATION
	if move_direction == Vector2.ZERO and velocity.length() > 0:
		acceleration = -velocity.normalized() * MOVE_DECELERATION
	
	# Integrate and clamp velocity
	velocity += acceleration * delta
	velocity = velocity.clamped(MAX_SPEED)
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	
	# Move and collide
	var collision = body.move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal) * bounce
	emit_signal("position_updated", body.global_position)
	emit_signal("velocity_updated", velocity)

func freeze(preserve_momentum: bool = true):
	if not preserve_momentum:
		velocity = Vector2.ZERO
	frozen = true

func unfreeze():
	frozen = false
