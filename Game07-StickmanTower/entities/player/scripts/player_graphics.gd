extends Node2D

onready var animation_player = $AnimationPlayer

func orient(dir: int):
	if dir == 1:
		scale.x = 1
	elif dir == -1:
		scale.x = -1

func play_anim(anim_name: String):
	animation_player.play(anim_name)
