extends GTEntityMover2D
class_name GTSteeringEntityMover2D

export (int) var max_speed = 128
export (int) var max_force = 64
export (float) var mass = 1.0

var target : Node2D
var behaviors = []

func _ready():
	._ready()
	for child in get_children():
		assert(child is GTSteeringBehavior2D, "%s has a non-SteeringAIBehavior" % [self.name])
		behaviors.append(child)

func _physics_process(delta):
	if frozen or not is_enabled:
		return
	for behavior in behaviors:
		behavior.move(delta)
	velocity = velocity.clamped(max_speed)
	._move(delta)

func set_target(_target: Node2D):
	target = _target
