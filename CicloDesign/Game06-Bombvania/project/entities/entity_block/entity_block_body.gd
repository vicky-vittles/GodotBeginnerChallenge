extends RigidBody2D

export (float) var push_force = 16.0

func push(direction):
	apply_central_impulse(direction * push_force)
