extends Node2D

onready var dungeon_loader = $DungeonLoader
onready var entities = $Entities
onready var cages = $Entities/Cages
onready var enemies = $Entities/Enemies
onready var projectiles = $Entities/Projectiles
onready var player = $Entities/Player

export (int) var starting_level

onready var current_level : int = starting_level
var teleporter_pos

func _process(delta):
	if not has_cage_or_enemy_alive():
		if dungeon_loader.level and dungeon_loader.level.end_trigger:
			var level = dungeon_loader.level
			level.end_trigger.global_position = level.teleporter_pos

func has_cage_or_enemy_alive() -> bool:
	return cages.get_child_count() > 0 or enemies.get_child_count() > 0

func load_dungeon():
	dungeon_loader.load_level(current_level, true)

func clear_dungeon():
	current_level += 1
	load_dungeon()

func add_entity(entity):
	if entity.entity_type == Globals.ENTITY_TYPES.ENTITY_PROJECTILE:
		projectiles.add_child(entity)
	elif entity.entity_type == Globals.ENTITY_TYPES.ENTITY_ENEMY:
		enemies.add_child(entity)
	elif entity.entity_type == Globals.ENTITY_TYPES.ENTITY_CAGE:
		cages.add_child(entity)
	else:
		entities.add_child(entity)
