extends MobileAccelerometerController
class_name MobileShakeController

signal updated_movement(movement)

export (Vector2) var min_movement = Vector2(4.0, 4.0)
export (Vector2) var max_movement = Vector2(12.0, 12.0)
export (Vector2) var movement_mask = Vector2(1, 1)
export (bool) var invert_movement = false
onready var movement_range = max_movement - min_movement

export (bool) var apply_grace_time = false
export (float) var grace_time_threshold = 0.75
export (float) var grace_time = 0.5
export (bool) var debug_mode = false
var move_direction : Vector2
var is_shaking : bool = false

onready var grace_timer = $GraceTimer

func _ready():
	grace_timer.wait_time = grace_time

func _on_updated_direction(acc_3d: Vector3):
	# Mapping from 3D to 2D
	var acc_2d = Vector2(acc_3d.x, acc_3d.y)
	
	# Clamp values to min-max range
	if acc_2d.x > 0:
		acc_2d.x = clamp(acc_2d.x, min_movement.x, max_movement.x)
	else:
		acc_2d.x = clamp(acc_2d.x, -max_movement.x, -min_movement.x)
	if acc_2d.y > 0:
		acc_2d.y = clamp(acc_2d.y, min_movement.y, max_movement.y)
	else:
		acc_2d.y = clamp(acc_2d.y, -max_movement.y, -min_movement.y)
	
	# Normalize it to range -1.0 to 1.0
	if acc_2d.x > 0:
		acc_2d.x = (acc_2d.x-min_movement.x)/movement_range.x
	else:
		acc_2d.x = (min_movement.x+acc_2d.x)/movement_range.x
	if acc_2d.y > 0:
		acc_2d.y = (acc_2d.y-min_movement.y)/movement_range.y
	else:
		acc_2d.y = (min_movement.y+acc_2d.y)/movement_range.y
	
	if apply_grace_time:
		if abs(acc_2d.x) > grace_time_threshold or abs(acc_2d.y) > grace_time_threshold:
			grace_timer.start()
	
	is_shaking = grace_timer.is_stopped()
	if grace_timer.is_stopped():
		move_direction = acc_2d
		if invert_movement:
			move_direction *= -1
		move_direction *= movement_mask
		if move_direction != Vector2.ZERO and debug_mode:
			print(move_direction)
		emit_signal("updated_movement", move_direction)
