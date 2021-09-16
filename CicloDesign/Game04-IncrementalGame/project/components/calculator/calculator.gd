extends Node

signal result(value)

enum OPERATORS {
	ADD = 1,
	SUBTRACT = 2,
	MULTIPLY = 3,
	DIVIDE = 4}

export (NodePath) var node_a_path
export (NodePath) var node_b_path
export (OPERATORS) var operator
export (bool) var emit_result = true
export (bool) var round_result = false

var node_a : GTPoints
var node_b : GTPoints

func _ready():
	node_a = get_node(node_a_path)
	node_b = get_node(node_b_path)

func calculate():
	var result = 0
	match operator:
		OPERATORS.ADD:
			result = node_a.current_points + node_b.current_points
		OPERATORS.SUBTRACT:
			result = node_a.current_points - node_b.current_points
		OPERATORS.MULTIPLY:
			result = node_a.current_points * node_b.current_points
		OPERATORS.DIVIDE:
			result = node_a.current_points / node_b.current_points
	if round_result:
		result = round(result)
	if emit_result:
		emit_signal("result", result)
	return result
