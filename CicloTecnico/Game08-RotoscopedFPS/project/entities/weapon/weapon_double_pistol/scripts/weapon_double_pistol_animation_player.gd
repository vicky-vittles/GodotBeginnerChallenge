extends "res://entities/weapon/weapon_animation_player.gd"

const SHOOT_LEFT = "shoot_left"
const SHOOT_RIGHT = "shoot_right"

var is_shooting_with_right : bool = true

func play_shoot():
	if is_shooting_with_right:
		play(SHOOT_RIGHT)
	else:
		play(SHOOT_LEFT)
	is_shooting_with_right = !is_shooting_with_right
