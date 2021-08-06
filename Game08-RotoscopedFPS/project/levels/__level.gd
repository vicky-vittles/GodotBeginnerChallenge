extends Spatial

signal checkpoint_reached(point)

export (String) var level_name
export (bool) var load_on_start = true
onready var checkpoint_file_path = "user://"+level_name+"-checkpoint.save"

onready var root = $root
onready var file_manager = $FileManager

var level_info = {}

func _ready():
	level_info = file_manager.load_file(checkpoint_file_path)
	if load_on_start:
		root.load_entities(level_info)

func create_checkpoint(player_info):
	level_info["entities"] = root.save_entities(checkpoint_file_path)
	level_info["entities"].append(player_info)
	file_manager.save_file(checkpoint_file_path, level_info)

func _on_checkpoint_reached(checkpoint):
	emit_signal("checkpoint_reached", checkpoint)
