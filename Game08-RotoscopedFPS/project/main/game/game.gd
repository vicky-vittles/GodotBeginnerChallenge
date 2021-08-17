extends Spatial

onready var world = $viewport_container/viewport/World

var is_mouse_captured : bool = true

#func _ready():
#	var qodot_fgd = load("res://addons/qodot/game_definitions/fgd/qodot_fgd.tres")
#	qodot_fgd.set_export_file(true)
#	get_node("World/Level/root/map").verify_and_build()

func _ready():
	randomize()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if Input.is_action_just_pressed("sys_escape"):
		if is_mouse_captured:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		is_mouse_captured = !is_mouse_captured

func add_entity(entity):
	world.level.root.map.add_child(entity)
