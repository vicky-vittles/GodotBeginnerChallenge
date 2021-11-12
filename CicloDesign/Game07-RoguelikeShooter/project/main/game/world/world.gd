extends Node2D

onready var projectiles = $Projectiles
onready var player = $Player
onready var camera = $Camera

func _ready():
	camera.add_target(player.body)

func add_entity(entity):
	if entity.entity_type == Globals.ENTITY_TYPES.ENTITY_PROJECTILE:
		projectiles.add_child(entity)
