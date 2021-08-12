extends Spatial

signal pressed_shoot()
signal weapon_fired()
signal weapon_reloading()

export (NodePath) var actor_path
export (Array, String) var bullet_groups
export (Array, String) var bullet_collidable_groups
export (Array, String) var bullet_excluded_groups
export (Array, String) var weapon_collidable_groups
export (Array, String) var weapon_excluded_groups
export (bool) var player_use = false
export (float) var MAX_DAMAGE = 50

onready var hud_root = $hud/root
onready var actor = get_node(actor_path)

var shoot_direction : Vector3
var look_direction : Vector3

func _ready():
	if not player_use:
		hud_root.visible = false

# Call this to validate shoot button press
func shoot(_shoot_dir: Vector3, _look_dir: Vector3):
	shoot_direction = _shoot_dir
	look_direction = _look_dir
	emit_signal("pressed_shoot")

# Override for weapon fire effect
func fire():
	pass
