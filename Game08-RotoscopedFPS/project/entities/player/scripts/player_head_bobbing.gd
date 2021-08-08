extends Spatial

const TWO_PI = 2*PI

export (NodePath) var input_controller_path
export (float) var bobbing_amount = 0.5
export (float) var bobbing_period = 0.5
export (float) var bobbing_threshold = 0.1
export (bool) var is_active = true

onready var input_controller = get_node(input_controller_path)
var bobbing_timer : float = 0.0

func _physics_process(delta):
	if not is_active:
		return
	var dir = input_controller.move_direction
	if dir == Vector2.ZERO:
		bobbing_timer = 0.0
		transform.origin.y = lerp(transform.origin.y, 0.0, 0.1)
		return
	bobbing_timer += delta
	bobbing_timer = fposmod(bobbing_timer, TWO_PI)
	
	var sin_wave = sin(TWO_PI*bobbing_timer/bobbing_period)
	var change = 0.0
	
	if abs(sin_wave) > bobbing_threshold:
		var total_movement = clamp(abs(dir.x)+abs(dir.y), 0.0, 1.0)
		change = total_movement*bobbing_amount*sin_wave
	transform.origin.y = change
