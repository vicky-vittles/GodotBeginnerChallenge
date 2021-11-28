extends GTEntityMover2D

const ANGLE_OFFSET = deg2rad(90)

export (float) var gravity = 256
export (float) var damping = 0.980
export (float) var swing_strength = 0.1
export (float) var arm_length = 80
export (float) var starting_angle = 45
export (float) var max_angle = 75

var pivot_pos : Vector2
var angle : float = 0.0
var angle_acc : float = 0.0
var angle_vel : float = 0.0
var move_direction : int

func _movement(delta):
	if frozen or not is_enabled:
		return
	var force = gravity * sin(angle-ANGLE_OFFSET)
	angle_acc = -force
	angle_vel += angle_acc*delta
	angle += angle_vel*delta
	angle_vel *= damping
	angle_vel -= move_direction*swing_strength
	
	var new_pos = Vector2.ZERO
	new_pos.x = -arm_length*sin(angle-ANGLE_OFFSET) + pivot_pos.x
	new_pos.y = arm_length*cos(angle-ANGLE_OFFSET) + pivot_pos.y
	
	velocity = (new_pos-body.global_position)/delta
	_move(delta)

func set_move_direction(dir: int) -> void:
	move_direction = dir

func set_info(_pivot: Vector2, dir: int):
	pivot_pos = _pivot
	angle = ANGLE_OFFSET+deg2rad(starting_angle)*sign(dir)
