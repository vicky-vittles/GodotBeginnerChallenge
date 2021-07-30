extends GTArea2D
class_name GTConnectedPair2D

signal effect(cause, effect, entity)

var CONNECTOR_GROUP : String

export (bool) var is_cause = true
export (String) var tag = "default"

func _ready():
	CONNECTOR_GROUP = "gt_connected_pair_2d"
	add_to_group(CONNECTOR_GROUP)
	connect("grouped_area_entered", self, "_on_grouped_area_entered")
	connect("grouped_body_entered", self, "_on_grouped_body_entered")

func _on_grouped_area_entered(area):
	if is_cause:
		get_tree().call_group(CONNECTOR_GROUP, "ripple", self, area)

func _on_grouped_body_entered(body):
	if is_cause:
		get_tree().call_group(CONNECTOR_GROUP, "ripple", self, body)

func ripple(cause, entity):
	if tag == cause.tag and not is_cause:
		emit_signal("effect", cause, self, entity)
