extends Node
class_name GTLogic

signal result(result)
signal succeded()
signal failed()

enum LOGIC_TYPE {
	AND,
	OR,
	NOT}

export (LOGIC_TYPE) var logic_type
export (bool) var emit_result = true

var value_a
var value_b

func set_value_a(value):
	value_a = value
	validate()

func set_value_b(value):
	value_b = value
	validate()

func validate():
	var result = true
	match logic_type:
		LOGIC_TYPE.AND:
			result = value_a and value_b
		LOGIC_TYPE.OR:
			result = value_a or value_b
		LOGIC_TYPE.NOT:
			result = not value_a
	if emit_result:
		if result:
			emit_signal("succeded")
		else:
			emit_signal("failed")
		emit_signal("result", result)
	return result
