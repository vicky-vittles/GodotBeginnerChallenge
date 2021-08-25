extends Node
class_name GTStateTransition

export (NodePath) var transition_state_path
var start_state : Node
var transition_state : Node


func _ready():
	assert(get_parent() is GTState)
	start_state = get_parent()
	transition_state = get_node(transition_state_path)

func conditions() -> bool:
	return true

func can_transition() -> bool:
	return conditions() and start_state.fsm.current_state == start_state

func do_transition():
	if can_transition():
		start_state.fsm.change_state(transition_state)
