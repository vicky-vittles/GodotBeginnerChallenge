extends Node2D

export (NodePath) var body_path
export (Vector2) var offset = Vector2(0, 16)
export (float) var time = 0.2
onready var body = get_node(body_path)
onready var tween = $Tween
onready var rect1 = $rect1

func _physics_process(delta):
	print(rect1.global_position)

func jump():
	rect1.visible = true
	tween.interpolate_property(rect1, "global_position", body.global_position, body.global_position + offset, time, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.interpolate_property(rect1, "modulate", Color.white, Color.transparent, time)
	tween.interpolate_property(rect1, "visible", true, false, time)
	tween.start()
