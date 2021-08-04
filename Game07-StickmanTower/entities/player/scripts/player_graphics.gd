extends Node2D

onready var animation_tree = $AnimationTree
onready var animation_tree_state_machine = animation_tree["parameters/playback"]

func orient(dir: int):
	if dir == 1:
		scale.x = 1
	elif dir == -1:
		scale.x = -1

func play_anim(anim_name: String):
	animation_tree_state_machine.travel(anim_name)
