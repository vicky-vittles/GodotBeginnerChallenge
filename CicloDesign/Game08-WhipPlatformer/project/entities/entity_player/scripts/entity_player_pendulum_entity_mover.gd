extends GTEntityMover2D

export (float) var gravity
export (float) var length
export (float) var max_angle

var vel_x : float = 0.0

func _movement(delta):
	if frozen or not is_enabled:
		return
	var x = body.global_position.x
	var y = body.global_position.y
	var acc_x = -gravity * (x/length) * (length-y)/length
	
	var new_x = x + (vel_x + (acc_x/2 * delta)) * delta
	var new_y = sqrt(length*length - new_x*new_x) - length
	vel_x += acc_x * delta
	
	velocity = Vector2(new_x, new_y) - Vector2(x, y)
	._move(delta)
