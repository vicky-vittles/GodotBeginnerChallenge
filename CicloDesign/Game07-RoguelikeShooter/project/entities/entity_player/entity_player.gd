extends "res://entities/__entity_topdown_player/__entity_topdown_player.gd"

export (NodePath) var _camera_path
export (bool) var weapon_fire_torrent = true

onready var mouse_controller = $MouseController
onready var rotation_pivot = $Body/graphics/rotation_pivot

func _ready():
	if _camera_path:
		var camera = get_node(_camera_path)
		mouse_controller.current_camera = camera

func _on_MouseController_updated_global_position(pos):
	aim_direction = body.global_position.direction_to(pos)
	rotation_pivot.look_at(pos)
