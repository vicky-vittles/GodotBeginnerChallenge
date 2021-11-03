extends Node
class_name GTEntityMover2D

signal updated_position(new_position)
signal has_collided()
signal collided(result)

enum MOVEMENT_MODE {
	MOVE_AND_COLLIDE = 1,
	MOVE_AND_SLIDE = 2,
	MOVE_AND_SLIDE_WITH_SNAP = 3}

export (float) var LENGTH_THRESHOLD = 4
export (NodePath) var body_path
export (MOVEMENT_MODE) var movement_mode = MOVEMENT_MODE.MOVE_AND_COLLIDE
export (int) var max_velocity = 256
export (Vector2) var floor_normal = Vector2.UP
export (bool) var stop_on_slope = false
export (int) var max_slides = 4
export (float) var floor_max_angle = 0.785398
export (bool) var infinite_inertia = true
export (bool) var interact_with_rigid_bodies = false
export (Vector2) var snap = Vector2.ZERO
export (Vector2) var movement_mask = Vector2(1,1)
export (float) var bounce_factor = 1.0
export (bool) var frozen = false
export (bool) var is_enabled = true
export (bool) var bounce_on_collision = false
export (bool) var debug_mode = false

var forces = []
var body : KinematicBody2D
var acceleration : Vector2
var velocity : Vector2

func _ready():
	assert(body_path != null, "%s has no body_path set" % [self.name])
	body = get_node(body_path)

func _physics_process(delta):
	if frozen or not is_enabled:
		return
	for i in forces.size():
		if forces[i][1] > 0.0:
			acceleration += forces[i][0]
			forces[i][1] -= delta
		else:
			forces.remove(i)
	velocity += acceleration * delta
	_move(delta)
	acceleration *= 0

func _move(delta) -> void:
	match movement_mode:
		MOVEMENT_MODE.MOVE_AND_COLLIDE:
			var collision = body.move_and_collide(velocity * movement_mask * delta)
			if collision:
				if bounce_on_collision:
					velocity = bounce_factor*velocity.bounce(collision.normal)
				_on_collision(collision)
				emit_signal("has_collided")
				emit_signal("collided", collision)
		MOVEMENT_MODE.MOVE_AND_SLIDE:
			velocity = body.move_and_slide(velocity * movement_mask, floor_normal, stop_on_slope, max_slides, floor_max_angle, infinite_inertia)
			if interact_with_rigid_bodies:
				for index in body.get_slide_count():
					var collision = body.get_slide_collision(index)
					if collision.collider.is_in_group("pushable"):
						collision.collider.push(-collision.normal)
		MOVEMENT_MODE.MOVE_AND_SLIDE_WITH_SNAP:
			velocity = body.move_and_slide_with_snap(velocity * movement_mask, snap, floor_normal)
	emit_signal("updated_position", body.global_position)

func _on_collision(result):
	pass

# Applies a force with a certain duration (if 0.0, then it's instantaneous)
func apply_force(force: Vector2, duration: float = 0.0) -> void:
	if not is_enabled:
		return
	acceleration += force
	if duration > 0.0:
		forces.append([force, duration])

func clear_forces():
	forces.clear()

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

func set_movement_mask(mask: Vector2) -> void:
	movement_mask = mask

func set_velocity(_velocity: Vector2) -> void:
	velocity = _velocity
