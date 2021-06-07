extends Control

const TRANSPARENT = Color(1.0, 1.0, 1.0, 0.0)
var transition

func _ready():
	for child in get_children():
		if child is ScreenTransition:
			transition = child
	assert(transition != null, "%s has no set Transition" % self.name)
	visible = false

func enter():
	transition.enter()

func exit():
	transition.exit()
