extends Node

export (NodePath) var actor_path
export (NodePath) var body_path
export (Globals.TRANSITION_TYPES) var transition_type
export (Globals.EASE_TYPES) var ease_type
export (float) var time_per_point = 1.0
export (bool) var is_loop = true
export (bool) var is_ping_pong = true
export (bool) var is_moving = true
onready var actor = get_node(actor_path)
onready var body = get_node(body_path)

var path = []
var current_point : int = 0
var next_point : int = -1
var direction : int = 1

var tween

func _ready():
	for child in actor.get_children():
		if child is GTPoint2D:
			path.append(child)
	tween = Tween.new()
	add_child(tween)
	if path.size() > 0:
		body.global_position = path[0].global_position
		set_next_point(1)
		tween.connect("tween_completed", self, "_on_Tween_tween_completed")

func _on_Tween_tween_completed(object, key):
	if not is_moving:
		return
	var is_final_point = (next_point+1) == path.size()
	var next
	if not is_loop and is_final_point:
		return
	if is_loop:
		if not is_ping_pong:
			direction = 1
		else:
			if not is_final_point:
				direction *= 1
			else:
				direction *= -1
		next = (next_point+direction) % path.size()
	set_next_point(next)

func set_next_point(_next):
	if not is_moving:
		return
	next_point = _next
	current_point = (next_point-direction) % path.size()
	tween.interpolate_property(body, "global_position", path[current_point].global_position, path[next_point].global_position, time_per_point, transition_type, ease_type)
	tween.start()

func enable():
	is_moving = true

func disable():
	is_moving = false
