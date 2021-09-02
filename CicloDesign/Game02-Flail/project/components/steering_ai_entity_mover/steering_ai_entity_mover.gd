extends Node
class_name SteeringAIEntityMover

export (NodePath) var body_path
var body : Node2D
var target : Vector2

export (int) var MAX_SPEED = 128
export (int) var MAX_FORCE = 64

export (bool) var debug_mouse_mode = false
export (float) var mass = 1.0
export (bool) var frozen = false

var behaviors = []
var velocity : Vector2

func _ready():
	body = get_node(body_path)
	assert(body != null, "%s has no body set" % [self.name])
	for child in get_children():
		assert(child is SteeringAIBehavior, "%s has a non-SteeringAIBehavior" % [self.name])
		behaviors.append(child)

func move(delta):
	if frozen:
		return
	if debug_mouse_mode:
		target = get_viewport().get_mouse_position()
	for behavior in behaviors:
		behavior.move(delta)
	velocity = velocity.clamped(MAX_SPEED)
	body.move_and_collide(velocity * delta)

func freeze(preserve_momentum: bool = true):
	if not preserve_momentum:
		velocity = Vector2.ZERO
	frozen = true

func unfreeze():
	frozen = false
