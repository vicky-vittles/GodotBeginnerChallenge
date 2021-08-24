extends Node
class_name GameLoader

const GAME = "res://main/game/game.tscn"

func load_game():
	get_tree().change_scene(GAME)
