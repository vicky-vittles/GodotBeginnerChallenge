extends Node
class_name GTFormula, "res://libs/gt_formula/icons/gt_formula.svg"

signal result(value)
signal succeded()
signal failed()

enum FORMULA_TYPE {
	EQUALS,
	NOT_EQUALS,
	GREATER_THAN,
	GREATER_OR_EQUAL,
	LESS_THAN,
	LESS_OR_EQUAL}

export (NodePath) var node_a_path
export (NodePath) var node_b_path
export (FORMULA_TYPE) var formula_type
export (bool) var emit_result = true
export (bool) var invert_result = false

var node_a : GTPoints
var node_b : GTPoints

func _ready():
	node_a = get_node(node_a_path)
	if node_b_path:
		node_b = get_node(node_b_path)

func validate() -> bool:
	var result = true
	var current_value = node_a.current_points
	var expected_value = node_b.current_points
	match formula_type:
		FORMULA_TYPE.EQUALS:
			result = current_value == expected_value
		FORMULA_TYPE.NOT_EQUALS:
			result = current_value != expected_value
		FORMULA_TYPE.GREATER_THAN:
			result = current_value > expected_value
		FORMULA_TYPE.GREATER_OR_EQUAL:
			result = current_value >= expected_value
		FORMULA_TYPE.LESS_THAN:
			result = current_value < expected_value
		FORMULA_TYPE.LESS_OR_EQUAL:
			result = current_value <= expected_value
	if invert_result:
		result = not result
	if emit_result:
		emit_signal("result", result)
		if result:
			emit_signal("succeded")
		else:
			emit_signal("failed")
	return result
