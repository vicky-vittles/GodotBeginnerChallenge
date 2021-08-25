extends Node
class_name GTStateTransition

export (NodePath) var transition_state_path
export (bool) var is_active = true
export (bool) var conditions_operator = true # If true, conditions() evaluate normally, otherwise, conditions() are inverted
var start_state : Node
var transition_state : Node


func _ready():
	assert(get_parent() is GTState)
	start_state = get_parent()
	transition_state = get_node(transition_state_path)

func conditions() -> bool:
	return true

func can_transition() -> bool:
	if not is_active:
		return false
	var conditions_met = conditions()
	if not conditions_operator:
		conditions_met = not conditions_met
	return conditions_met and start_state.fsm.current_state == start_state

func do_transition():
	if can_transition():
		start_state.fsm.change_state(transition_state)
