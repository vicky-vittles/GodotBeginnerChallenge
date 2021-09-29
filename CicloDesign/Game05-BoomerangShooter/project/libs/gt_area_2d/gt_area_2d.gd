extends Area2D
class_name GTArea2D

signal grouped_area_entered(area)
signal grouped_area_exited(area)
signal grouped_body_entered(body)
signal grouped_body_exited(body)

export (NodePath) var body_path
export (Array, String) var collidable_groups
export (Array, String) var excluded_groups
export (bool) var disable_on_ready = false

var is_area_colliding : bool = false
var is_body_colliding : bool = false
var collider_area : Node2D
var collider_body : Node2D
var body

func _ready():
	body = get_node(body_path)
	assert(body != null, "%s has no body set" % [self.name])
	connect("area_entered", self, "_on_area_entered")
	connect("area_exited", self, "_on_area_exited")
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	if disable_on_ready:
		disable_all_shapes()

func is_node_collidable(node: Node) -> bool:
	for group in excluded_groups:
		if node.is_in_group(group):
			return false
	
	if collidable_groups.empty():
		return true
	
	for group in collidable_groups:
		if node.is_in_group(group):
			return true
	return false

func _on_area_entered(area: Area2D) -> void:
	if is_node_collidable(area):
		is_area_colliding = true
		collider_area = area
		emit_signal("grouped_area_entered", area)

func _on_area_exited(area: Area2D) -> void:
	if is_node_collidable(area):
		is_area_colliding = false
		collider_area = null
		emit_signal("grouped_area_exited", area)

func _on_body_entered(_body: Node) -> void:
	if is_node_collidable(_body):
		is_body_colliding = true
		collider_body = _body
		emit_signal("grouped_body_entered", _body)

func _on_body_exited(_body: Node) -> void:
	if is_node_collidable(_body):
		is_body_colliding = false
		collider_body = null
		emit_signal("grouped_body_exited", _body)

func enable_all_shapes() -> void:
	for child in get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", false)

func disable_all_shapes() -> void:
	for child in get_children():
		if child is CollisionShape2D:
			child.set_deferred("disabled", true)
