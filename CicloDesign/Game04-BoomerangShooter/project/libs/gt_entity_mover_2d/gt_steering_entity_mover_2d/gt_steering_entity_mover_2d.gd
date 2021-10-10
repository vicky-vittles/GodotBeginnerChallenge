extends GTEntityMover2D
class_name GTSteeringEntityMover2D

export (bool) var use_target_node
export (int) var max_speed = 128
export (int) var max_force = 64
export (float) var mass = 1.0

var _target : Node2D
var _target_pos : Vector2
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

func get_target_pos() -> Vector2:
	if use_target_node and _target:
		return _target.global_position
	return _target_pos

func set_target(t: Node2D):
	_target = t

func set_target_pos(_pos : Vector2):
	_target_pos = _pos
