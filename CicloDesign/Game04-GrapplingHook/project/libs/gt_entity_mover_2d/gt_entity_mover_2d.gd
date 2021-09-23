extends Node
class_name GTEntityMover2D

signal updated_position(new_position)
signal collided(result)

enum MOVEMENT_MODE {
	MOVE_AND_COLLIDE = 1,
	MOVE_AND_SLIDE = 2,
	MOVE_AND_SLIDE_WITH_SNAP = 3}

export (NodePath) var body_path
export (MOVEMENT_MODE) var movement_mode = MOVEMENT_MODE.MOVE_AND_COLLIDE
export (Vector2) var floor_normal = Vector2.UP
export (Vector2) var snap = Vector2.ZERO
export (Vector2) var movement_mask = Vector2(1,1)
export (bool) var frozen = false
export (bool) var is_enabled = true

var body : KinematicBody2D
var acceleration : Vector2
var velocity : Vector2

func _ready():
	assert(body_path != null, "%s has no body_path set" % [self.name])
	body = get_node(body_path)

func _physics_process(delta):
	if frozen or not is_enabled:
		return
	velocity += acceleration * delta
	move(delta)
	acceleration *= 0

func move(delta) -> void:
	match movement_mode:
		MOVEMENT_MODE.MOVE_AND_COLLIDE:
			var collision = body.move_and_collide(velocity * movement_mask * delta)
			if collision:
				emit_signal("collided", collision)
		MOVEMENT_MODE.MOVE_AND_SLIDE:
			velocity = body.move_and_slide(velocity * movement_mask, floor_normal)
		MOVEMENT_MODE.MOVE_AND_SLIDE_WITH_SNAP:
			velocity = body.move_and_slide_with_snap(velocity * movement_mask, snap, floor_normal)
	emit_signal("updated_position", body.global_position)

# Applies a force
func apply_force(force: Vector2) -> void:
	acceleration += force

# Freezes the body, preserving momentum or not
func freeze(preserve_momentum: bool = true) -> void:
	if not preserve_momentum:
		velocity = Vector2.ZERO
	frozen = true

# Unfreezes the body, allowing it to move again
func unfreeze() -> void:
	frozen = false

# Enables the entity mover
func enable() -> void:
	is_enabled = true

# Disables the entity mover
func disable() -> void:
	is_enabled = false
