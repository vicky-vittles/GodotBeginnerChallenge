extends Node2D

onready var animation_player = $AnimationPlayer

func show_text():
	animation_player.play("show")

func hide_text():
	animation_player.play("hide")
