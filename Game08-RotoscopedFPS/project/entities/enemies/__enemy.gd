extends KinematicBody

export (bool) var can_shoot = true

enum { PLAYER, ENEMY }

onready var entity_mover = $EntityMover
onready var health = $Health
onready var animation_player = $AnimationPlayer

var move_direction : Vector2 = Vector2.ZERO
var shoot_direction : Vector3 = Vector3.RIGHT
var near_entities = {}
var is_near_player : bool = false

func _on_PlayerDetector_grouped_area_entered(area):
	if not near_entities.has(area.actor):
		if area.is_in_group("player_presence"):
			near_entities[area.actor] = PLAYER
			is_near_player = true
		elif area.is_in_group("enemy_presence"):
			near_entities[area.actor] = ENEMY

func _on_PlayerDetector_grouped_area_exited(area):
	if near_entities.has(area.actor):
		near_entities.erase(area.actor)
	for entity in near_entities.keys():
		if near_entities[entity] == PLAYER:
			is_near_player = true
			break
	is_near_player = false

func get_nearest_player():
	for entity in near_entities.keys():
		if near_entities[entity] == PLAYER:
			return entity
