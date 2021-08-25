extends Node2D

export (Vector2) var final_pos = Vector2(0, -4)
export (float) var anim_delay = 0.0

onready var main = $main
onready var tween = $Tween
onready var timer = $Timer

func _ready():
	floating_anim()

func floating_anim():
	timer.start()
	tween.interpolate_property(main, "position", Vector2.ZERO, final_pos, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.0 + anim_delay)
	tween.interpolate_property(main, "position", final_pos, Vector2.ZERO, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN, 1.0 + anim_delay)
	tween.start()
