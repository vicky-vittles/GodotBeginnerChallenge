extends GTEntityMover2D

export (float) var gravity = 128.0
export (float) var damping = 0.995
export (float) var length = 64.0
export (float) var max_angle = 60.0

var pivot_point : Vector2
var angle : float
var angular_vel : float
var angular_acc : float

func _movement(delta):
	if frozen or not is_enabled:
		return
	
	angular_acc = ((-gravity*delta) / length) * sin(angle)
	angular_vel += angular_acc
	angular_vel *= damping
	angle += angular_vel
	var new_pos = pivot_point + Vector2(length*sin(angle), length*cos(angle))
	
	velocity = new_pos-body.global_position
	._move(delta)

func set_info(start_pos: Vector2):
	pivot_point = start_pos
	length = Vector2.ZERO.distance_to(body.global_position - pivot_point)
	angle = Vector2.ZERO.angle_to(body.global_position - pivot_point) - deg2rad(-90)
	angular_vel = 0.0
	angular_acc = 0.0
