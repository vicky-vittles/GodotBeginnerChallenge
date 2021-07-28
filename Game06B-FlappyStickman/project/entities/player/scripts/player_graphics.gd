extends Node2D

onready var animation_player = $AnimationPlayer

func play_anim(anim_name: String):
	animation_player.play(anim_name)
