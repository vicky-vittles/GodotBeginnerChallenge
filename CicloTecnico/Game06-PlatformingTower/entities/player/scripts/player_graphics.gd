extends Node2D

onready var animation_player = $AnimationPlayer

func orient(direction: int):
	if direction == 1:
		scale.x = 1
	elif direction == -1:
		scale.x = -1

func play(anim_name):
	animation_player.play(anim_name)
