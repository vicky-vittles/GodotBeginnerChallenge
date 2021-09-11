extends GTTriggerArea2D

onready var repeat_timer = $Graphics/color/floating/RepeatTimer
onready var path_entity_mover = $PathEntityMover

func _ready():
	if path_entity_mover.points.size() > 0:
		repeat_timer.stop()
