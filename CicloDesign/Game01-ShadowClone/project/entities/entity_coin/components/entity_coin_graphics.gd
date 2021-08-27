extends Node2D

export (NodePath) var body_path
onready var body = get_node(body_path)
export (Vector2) var final_pos = Vector2(0, -4)
var anim_delay : float = 0.0

onready var main = $main
onready var tween = $Tween
onready var timer = $Timer

func _ready():
	anim_delay = randf()*2
	floating_anim()

func floating_anim():
	timer.start()
	tween.interpolate_property(body, "position", Vector2.ZERO, final_pos, 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN, 0.0 + anim_delay)
	tween.interpolate_property(body, "position", final_pos, Vector2.ZERO, 1.0, Tween.TRANS_CUBIC, Tween.EASE_IN, 1.0 + anim_delay)
	tween.start()
