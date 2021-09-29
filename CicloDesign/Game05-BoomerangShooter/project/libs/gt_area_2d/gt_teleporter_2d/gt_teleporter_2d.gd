extends GTArea2D
class_name GTTeleporter2D

signal teleported_entity(cause, entity)

var CONNECTOR_GROUP : String = "gt_teleporter_2d"

export (bool) var is_cause = true
export (bool) var is_indirect = false
export (String) var tag = "default"
export (float) var delay = 1.0

var _delay_timer : Timer
var _entity_to_teleport : Node
var _pos_to_teleport : Vector2

func _ready():
	add_to_group(CONNECTOR_GROUP)
	_delay_timer = Timer.new()
	_delay_timer.one_shot = true
	add_child(_delay_timer)
	_delay_timer.connect("timeout", self, "_perform_teleport")
	connect("grouped_area_entered", self, "_on_grouped_area_entered")
	connect("grouped_body_entered", self, "_on_grouped_body_entered")

func _on_grouped_area_entered(area):
	if is_cause:
		get_tree().call_group(CONNECTOR_GROUP, "teleport", self, area)

func _on_grouped_body_entered(body):
	if is_cause:
		get_tree().call_group(CONNECTOR_GROUP, "teleport", self, body)

func teleport(cause, entity):
	if tag == cause.tag and not is_cause:
		_pos_to_teleport = global_position
		_entity_to_teleport = entity if not is_indirect else entity.body
		if delay > 0.0:
			_delay_timer.start()
		else:
			_perform_teleport()
		emit_signal("teleported_entity", cause, entity)

func _perform_teleport():
	if _entity_to_teleport and _pos_to_teleport != Vector2.ZERO:
		_entity_to_teleport.global_position = _pos_to_teleport
