extends Node

export (float) var boost_anim_time = 0.5
export (NodePath) var body_path

onready var body = get_node(body_path)
onready var boost_vfx = $boost
onready var boost_rect1 = $boost/rect1
onready var tween = $Tween

func _ready():
	boost_rect1.visible = false

func boost(is_hit: bool):
	boost_vfx.global_position = body.global_position
	boost_rect1.visible = true
	var max_rotation = 720 if is_hit else 360
	tween.interpolate_property(boost_rect1, "size", 0, 128, boost_anim_time)
	tween.interpolate_property(boost_rect1, "border_size", 32, 0, boost_anim_time)
	tween.interpolate_property(boost_rect1, "polygon_rotation", 0, max_rotation, boost_anim_time)
	tween.interpolate_property(boost_rect1, "visible", true, false, boost_anim_time)
	tween.start()
