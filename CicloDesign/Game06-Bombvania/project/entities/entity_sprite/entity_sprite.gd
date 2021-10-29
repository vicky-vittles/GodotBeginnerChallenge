extends GTEntity2D

enum SPRITE_TYPES {
	ROCK_ANIMATED = 1}

const ANIM_NAMES = {
	SPRITE_TYPES.ROCK_ANIMATED: "rock_animated"}

onready var animation_player = $AnimationPlayer

var sprite_type : int

func play():
	animation_player.play(ANIM_NAMES[sprite_type])
