extends Node2D

export (NodePath) var body_path
export (Vector2) var margin = Vector2(100, 50)

onready var bounds = get_viewport().get_visible_rect()
onready var body = get_node(body_path)

func _physics_process(delta):
	#visible = not bounds.has_point(body.global_position)
	global_position.x = clamp(body.global_position.x, margin.x, bounds.size.x-margin.x)
	global_position.y = clamp(body.global_position.y, margin.y, bounds.size.y-margin.y)
	look_at(body.global_position)
