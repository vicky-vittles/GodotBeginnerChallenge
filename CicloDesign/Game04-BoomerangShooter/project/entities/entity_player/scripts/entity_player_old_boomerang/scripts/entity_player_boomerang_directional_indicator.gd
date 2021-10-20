extends Node2D

export (NodePath) var body_path

onready var body = get_node(body_path)
onready var line = $line

func _physics_process(delta):
	var direction = body.actor.return_entity_mover.move_direction
	global_position = body.global_position
	rotation = direction.angle()

func appear():
	line.points = [Vector2.ZERO, Vector2(-1600, 0)]
