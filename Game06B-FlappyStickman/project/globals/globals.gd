extends Node

const SCORE_FILE = "user://score.save"

var highscore

func _ready():
	load_score()

func _process(delta):
	if Input.is_action_just_pressed("sys_reload"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("sys_exit"):
		get_tree().quit()

func save_score(score: int):
	highscore = score
	var file = File.new()
	file.open(SCORE_FILE, File.WRITE)
	file.store_var(highscore)
	file.close()

func load_score():
	var file = File.new()
	if file.file_exists(SCORE_FILE):
		file.open(SCORE_FILE, File.READ)
		highscore = file.get_var()
		file.close()
	else:
		highscore = 0
