extends Node2D

onready var key = $key
onready var door = $door
onready var animation_player = $AnimationPlayer

func open_door():
	key.set_deferred("monitoring", false)
	animation_player.play("hide")
	for child in door.get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", true)
