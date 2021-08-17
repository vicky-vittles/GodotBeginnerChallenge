extends Spatial

signal player_killed_zombie()

enum LEVELS {
	TEST_00 = 0,
	FOREST_01 = 1,
	DUNGEON_02 = 2}

const LEVEL_SCENES = {
	LEVELS.TEST_00: preload("res://levels/L00_Test.tscn"),
	LEVELS.FOREST_01: preload("res://levels/L01_Forest.tscn"),
	LEVELS.DUNGEON_02: preload("res://levels/L02_Dungeon.tscn")}

export (LEVELS) var current_level = LEVELS.TEST_00

onready var enemies_remaining = $HUD/root/enemies_remaining
onready var hud_animation_player = $HUD/root/AnimationPlayer
onready var player = $Player
var level

func _ready():
	load_level(current_level)

func load_level(level_id):
	var level_node = LEVEL_SCENES[level_id].instance()
	add_child(level_node)
	level_node.connect("killed_zombie", self, "emit_signal", ["player_killed_zombie"])
	level = level_node

func _on_ZombiesKilled_amount_updated(current):
	var remaining_enemies = level.total_enemies_to_kill-current
	if remaining_enemies <= 10:
		enemies_remaining.apply_text_simple(remaining_enemies)
		hud_animation_player.play("show_enemies_remaining")

func _on_Player_died():
	print("morri")
