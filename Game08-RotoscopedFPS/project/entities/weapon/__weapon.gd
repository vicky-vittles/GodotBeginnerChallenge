extends Spatial

signal pressed_shoot()

export (NodePath) var actor_path
onready var actor = get_node(actor_path)

var shoot_direction : Vector3
var look_direction : Vector3

# Call this to validate shoot button press
func shoot(_shoot_dir: Vector3, _look_dir: Vector3):
	shoot_direction = _shoot_dir
	look_direction = _look_dir
	emit_signal("pressed_shoot")

# Override for weapon fire effect
func fire():
	pass
