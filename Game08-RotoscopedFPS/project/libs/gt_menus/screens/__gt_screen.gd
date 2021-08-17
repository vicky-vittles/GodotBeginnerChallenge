extends Control
class_name GTScreen

var enter_transition
var exit_transition

func _ready():
	for child in get_children():
		if child is GTScreenTransition:
			if child.is_enter:
				enter_transition = child
			else:
				exit_transition = child

func enter():
	enter_transition.enter()

func exit():
	exit_transition.exit()
