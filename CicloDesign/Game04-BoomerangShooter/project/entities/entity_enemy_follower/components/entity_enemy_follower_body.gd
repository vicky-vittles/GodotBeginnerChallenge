extends KinematicBody2D

onready var entity_mover = $EntityMover

func _physics_process(delta):
	var direction = entity_mover.velocity.normalized()
	if direction != Vector2.ZERO:
		rotation = direction.normalized().angle()
