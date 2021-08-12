extends Spatial

enum LEVELS {
	TEST_00 = 0,
	FOREST_01 = 1,
	DUNGEON_02 = 2}

const LEVEL_SCENES = {
	LEVELS.TEST_00: preload("res://levels/L00_Test.tscn"),
	LEVELS.FOREST_01: preload("res://levels/L01_Forest.tscn"),
	LEVELS.DUNGEON_02: preload("res://levels/L02_Dungeon.tscn")}

export (LEVELS) var current_level = LEVELS.TEST_00

onready var player = $Player
onready var checkpoint_manager = $CheckpointManager
var level

func _ready():
	load_level(current_level)

func load_level(level_id):
	var level_node = LEVEL_SCENES[level_id].instance()
	add_child(level_node)
	level_node.connect("checkpoint_reached", self, "checkpoint_reached")
	level = level_node

func checkpoint_reached(checkpoint):
	var current_point = checkpoint_manager.current_amount
	var new_point = checkpoint.checkpoint_id
	
	if new_point > current_point:
		checkpoint_manager.set_amount(new_point)
		level.create_checkpoint(player.get_info())

func _on_Player_died():
	print("morri")
