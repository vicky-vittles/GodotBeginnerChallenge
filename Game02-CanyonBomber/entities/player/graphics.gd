extends Node2D

const BOMB_READY_WHITE = preload("res://assets/images/bomb-ready-white.png")
const BOMB_READY_BLACK = preload("res://assets/images/bomb-ready-black.png")

onready var player = get_parent()

func set_orientation(dir: Vector2):
	if sign(dir.x) == 1:
		scale.x = 1
	if sign(dir.x) == -1:
		scale.x = -1

func set_player_id(id: int):
	get_node("main").frame = id-1
	if player.player_id == 1:
		get_node("bomb_ready").texture = BOMB_READY_WHITE
	elif player.player_id == 2:
		get_node("bomb_ready").texture = BOMB_READY_BLACK
