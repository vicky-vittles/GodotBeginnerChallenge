extends Node
class_name GTPathEntityMover2D

const DISTANCE_THRESHOLD = 2*2

enum TRANSITION_TYPES {
	TRANS_LINEAR = 0,
	TRANS_SINE = 1,
	TRANS_QUAD = 4,
	TRANS_CUBIC = 7,
	TRANS_QUART = 3,
	TRANS_QUINT = 2,
	TRANS_EXPO = 5,
	TRANS_CIRC = 8,
	TRANS_BACK = 10,
	TRANS_BOUNCE = 9,
	TRANS_ELASTIC = 6}

enum EASE_TYPES {
	EASE_IN = 0,
	EASE_OUT = 1,
	EASE_IN_OUT = 2,
	EASE_OUT_IN = 3}

export (NodePath) var points_parent_path
export (NodePath) var body_path
export (TRANSITION_TYPES) var transition_type
export (EASE_TYPES) var ease_type
export (float) var duration
export (bool) var is_loop = true
export (bool) var is_ping_pong = true
export (bool) var is_active = true

var points_parent : Node
var body : Node

var points = []
var path = [] # List of points remaining to complete path
var is_forward : bool = true # Whether or not body is going forward or backward in relation to path
var path_length : float

var tween : Tween

func _ready():
	points_parent = get_node(points_parent_path)
	body = get_node(body_path)
	assert(points_parent != null, "%s has no points_parent set" % [self.name])
	assert(body != null, "%s has no body set" % [self.name])
	for child in points_parent.get_children():
		if child is GTPoint2D:
			points.append(child.global_position)
	tween = Tween.new()
	add_child(tween)
	tween.name = "_Tween"
	tween.connect("tween_all_completed", self, "_on_Tween_all_completed")
	start_movement()

func start_movement():
	if not is_active: return
	if not points or points.size() == 0: return
	path = points.duplicate()
	path_length = get_path_length(points)
	if not is_forward and is_ping_pong:
		path.invert()
	is_forward = not is_forward
	next_point()

func next_point():
	if not is_active: return
	if path.size() > 1:
		var current_distance = path[0].distance_to(path[1])
		var current_time = duration*current_distance/path_length
		tween.interpolate_property(body, "global_position", path[0], path[1], current_time, transition_type, ease_type)
		tween.start()
	elif is_loop:
		start_movement()

func _on_Tween_all_completed():
	if path.size() > 0:
		path.pop_front()
	next_point()

func get_path_length(_points) -> float:
	var total_distance = 0.0
	for i in _points.size()-1:
		total_distance += _points[i].distance_to(_points[i+1])
	return total_distance
