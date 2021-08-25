extends Node
class_name GTStateTransition

export (NodePath) var end_state_path
export (bool) var is_active = true
var start_state : Node
var end_state : Node


func _ready():
	assert(get_parent() is GTState)
	start_state = get_parent()
	end_state = get_node(end_state_path)

func can_transition() -> bool:
	return is_active and start_state.fsm.current_state == start_state

func do_transition():
	if can_transition():
		start_state.fsm.change_state(end_state)
