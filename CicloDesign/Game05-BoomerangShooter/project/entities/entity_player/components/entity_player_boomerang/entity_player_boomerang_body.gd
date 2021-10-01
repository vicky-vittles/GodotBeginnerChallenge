extends KinematicBody2D

export (NodePath) var actor_path
onready var actor = get_node(actor_path)
onready var animation_player = $AnimationPlayer

func appear():
	animation_player.play("appear")

func disappear():
	animation_player.play("disappear")
