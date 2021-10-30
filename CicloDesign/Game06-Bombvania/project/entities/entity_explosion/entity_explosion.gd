extends GTEntity2D

signal inactive(object)
signal finished(explosion)

onready var graphics = $Body/visuals/graphics
onready var inactive_to_active_transition = $StateMachine/Inactive/ToActive

var has_destroyed_tile : bool = false

func reset_object_pool():
	inactive_to_active_transition.do_transition()

func destroyed_tile(): has_destroyed_tile = true
func animate(): graphics.visible = not has_destroyed_tile
func finish():
	emit_signal("finished", self)

func _on_Inactive_state_entered(): emit_signal("inactive", self)
