extends Node2D

export (NodePath) var actor_path
export (NodePath) var body_path

onready var actor = get_node(actor_path)
onready var body = get_node(body_path)

var target_pos : Vector2

func _physics_process(delta):
	global_position = body.global_position
	look_at(actor.target_position)
