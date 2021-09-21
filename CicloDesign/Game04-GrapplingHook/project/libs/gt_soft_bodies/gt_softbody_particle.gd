extends KinematicBody2D
class_name GTSoftBodyParticle

export (float) var gravity = 300.0
export (float, 0.0, 1.0) var velocity_damping = 0.99
export (bool) var apply_gravity = true
export (bool) var frozen = false

var velocity : Vector2
var acceleration : Vector2

func _init(pos: Vector2):
	global_position = pos
	var col_shape = CollisionShape2D.new()
	col_shape.shape = CircleShape2D.new()
	col_shape.shape.radius = 1.0
	add_child(col_shape)

func _physics_process(delta):
	if frozen:
		return
	if apply_gravity:
		apply_force(Vector2(0.0, gravity))
	
	velocity *= velocity_damping
	velocity += acceleration * delta
	move_and_collide(velocity * delta)
	acceleration *= 0

func apply_force(force: Vector2):
	acceleration += force

func freeze(preserve_momentum: bool = true):
	if not preserve_momentum:
		velocity = Vector2.ZERO
	frozen = true

func unfreeze():
	frozen = false
