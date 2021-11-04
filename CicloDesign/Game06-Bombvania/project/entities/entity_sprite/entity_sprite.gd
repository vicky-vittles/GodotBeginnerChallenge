extends GTEntity2D

const ANIM_NAMES = {
	Globals.SPRITE_TYPES.ROCK_ANIMATED: "rock_animated",
	Globals.SPRITE_TYPES.WOODEN_FENCE_ANIMATED: "wooden_fence_animated"}

onready var animation_player = $AnimationPlayer

var sprite_type : int

func play():
	animation_player.play(ANIM_NAMES[sprite_type])
