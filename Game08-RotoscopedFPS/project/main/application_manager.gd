extends Node
class_name ApplicationManager

enum SCENES {
	MAIN,
	GAME}

const SCENES_PATH = {
	SCENES.MAIN : "res://main/main.tscn",
	SCENES.GAME : "res://main/game/game.tscn"}

func load_scene(scene: int):
	if SCENES.has(scene):
		get_tree().change_scene(SCENES_PATH[scene])

func reload():
	get_tree().reload_current_scene()

func quit():
	get_tree().quit()
