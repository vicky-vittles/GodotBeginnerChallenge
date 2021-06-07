extends Node
class_name ScreenTransition

onready var screen = get_parent()
onready var tween = $Tween
onready var v_timer = $VisibilityTimer
export (float) var anim_time = 1.0

func _ready():
	v_timer.wait_time = anim_time

func enter():
	pass

func exit():
	pass

func disable_screen():
	screen.visible = false
