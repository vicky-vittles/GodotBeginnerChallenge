extends GTEntity2D

onready var animation_player = $Graphics/AnimationPlayer

func play():
	animation_player.play("boost")
