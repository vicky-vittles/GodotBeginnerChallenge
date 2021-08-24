extends Node2D

export (int) var move_amount = 24
export (float) var move_speed = 0.5
export (bool) var is_active = false

onready var zero_movement_timer = $ZeroMovementTimer

var mouse_movement : Vector2

func _input(event):
	if is_active and event is InputEventMouseMotion:
		mouse_movement = event.relative.normalized()
		zero_movement_timer.start()

func _physics_process(delta):
	var move = -mouse_movement.normalized()*move_amount
	position = lerp(position, move, move_speed * delta)

func _on_ZeroMovementTimer_timeout():
	mouse_movement = Vector2.ZERO
