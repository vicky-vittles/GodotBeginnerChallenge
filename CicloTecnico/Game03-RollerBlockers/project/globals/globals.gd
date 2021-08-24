extends Node

const DATA_FILE_PATH = "user://data.save"
const NUMBER_OF_LEVELS = 4
const LEVELS = {
	1: preload("res://levels/levels/L01.tscn"),
	2: preload("res://levels/levels/L02.tscn"),
	3: preload("res://levels/levels/L03.tscn"),
	4: preload("res://levels/levels/L04.tscn")}

var current_level : int = 1
var max_level_reached : int = 1

func _ready():
	load_data()

func save_data():
	var file = File.new()
	file.open(DATA_FILE_PATH, File.WRITE)
	file.store_var(max_level_reached)
	file.close()

func load_data():
	var file = File.new()
	if file.file_exists(DATA_FILE_PATH):
		file.open(DATA_FILE_PATH, File.READ)
		max_level_reached = file.get_var()
		file.close()
	else:
		max_level_reached = 1
