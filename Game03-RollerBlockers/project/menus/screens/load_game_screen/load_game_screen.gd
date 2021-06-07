extends "res://libs/menus/screens/_screen.gd"

const GAME = "res://main/game/game.tscn"

func load_game(level_id: int):
	Globals.current_level = level_id
	get_tree().change_scene(GAME)
