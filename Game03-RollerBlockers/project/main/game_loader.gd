extends Node
class_name GameLoader

const GAME = "res://main/game/game.tscn"

func continue_game():
	Globals.current_level = Globals.max_level_reached
	get_tree().change_scene(GAME)

func load_game(level_id: int):
	Globals.current_level = level_id
	get_tree().change_scene(GAME)
