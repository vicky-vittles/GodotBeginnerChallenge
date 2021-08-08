extends Spatial

export (NodePath) var input_controller_path
export (float) var tilt_amount = 10
export (float) var tilt_speed = 0.5
export (bool) var is_active = true

onready var input_controller = get_node(input_controller_path)

func _physics_process(delta):
	if not is_active:
		return
	var speed = tilt_speed if input_controller.move_direction.x != 0 else 4.5
	var tilt = -1*input_controller.move_direction.x*tilt_amount
	rotation_degrees.z = lerp(rotation_degrees.z, tilt, speed * delta)
