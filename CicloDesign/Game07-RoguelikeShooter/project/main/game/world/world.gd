extends Node2D

onready var dungeon = $Dungeon
onready var entities = $Entities
onready var projectiles = $Entities/Projectiles
onready var enemies = $Entities/Enemies
onready var player = $Entities/Player

func generate_dungeon():
	dungeon.player = player
	var steps_history = dungeon.generate_dungeon()
	var spawn_point = steps_history[0] * Globals.TILE_SIZE * Vector2.ONE
	player.global_position = spawn_point + Globals.TILE_SIZE * Vector2.ONE/2

func add_entity(entity):
	if entity.entity_type == Globals.ENTITY_TYPES.ENTITY_PROJECTILE:
		projectiles.add_child(entity)
	elif entity.entity_type == Globals.ENTITY_TYPES.ENTITY_ENEMY:
		enemies.add_child(entity)
	else:
		entities.add_child(entity)
