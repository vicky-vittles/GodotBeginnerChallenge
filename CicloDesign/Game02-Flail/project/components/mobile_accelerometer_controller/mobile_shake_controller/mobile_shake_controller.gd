extends MobileAccelerometerController
class_name MobileShakeController

signal updated_movement(movement)

export (float) var movement_threshold = 5.0
export (float) var shake_cooldown_time = 0.1
export (Vector2) var movement_mask = Vector2(1, 1)
export (bool) var invert_movement = false
export (bool) var debug_mode = false

var move_direction : Vector2

onready var cooldown_timer = $CooldownTimer

func _ready():
	cooldown_timer.wait_time = shake_cooldown_time

func _on_updated_direction(acc_3d: Vector3):
	# Mapping from 3D to 2D
	var acc_2d = Vector2(acc_3d.x, acc_3d.y)
	move_direction = Vector2.ZERO
	
	# Reset movement on axis that is smaller than threshold
	if abs(acc_2d.x) < movement_threshold:
		acc_2d.x = 0.0
	if abs(acc_2d.y) < movement_threshold:
		acc_2d.y = 0.0
	
	# If at least one axis is above threshold, perform movement
	if abs(acc_2d.x) >= movement_threshold or abs(acc_2d.y) >= movement_threshold:
		if cooldown_timer.is_stopped():
			move_direction = acc_2d.normalized()
			cooldown_timer.start()
	
	# Apply masks, print debug and emit move_direction
	if invert_movement:
		move_direction *= -1
	move_direction *= movement_mask
	if move_direction != Vector2.ZERO and debug_mode:
		print(move_direction)
	emit_signal("updated_movement", move_direction)
