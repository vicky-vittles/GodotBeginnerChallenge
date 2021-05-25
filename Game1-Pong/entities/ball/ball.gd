extends KinematicBody2D

const SPEED = 250

var direction : Vector2
var velocity : Vector2

func set_direction(_dir):
	direction = _dir

func _physics_process(delta):
	velocity = SPEED * direction
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.collider
		if collider.is_in_group("paddle"):
			direction = direction.bounce(collision.normal)
		else:
			direction = direction.bounce(collision.normal)
