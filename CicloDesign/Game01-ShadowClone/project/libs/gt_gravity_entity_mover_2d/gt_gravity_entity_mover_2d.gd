extends Node
class_name GTGravityEntityMover2D

signal position_updated(pos)
signal movement_info(info)
signal jumped()

export (NodePath) var body_path
onready var body = get_node(body_path)

export (int) var MOVE_SPEED = 256
export (float) var JUMP_SPEED = -1024
export (float) var GRAVITY = 2048
export (float, 0.0, 1.0) var JUMP_DAMPING = 0.3
export (int) var MAX_JUMPS = 1
export (Vector2) var ground_snap = Vector2.DOWN * 8

export (Vector2) var movement_mask = Vector2(1, 1)
export (Vector2) var floor_normal = Vector2.UP
export (bool) var apply_gravity = true
export (bool) var frozen = false

var move_direction : int
var velocity : Vector2
var acceleration : Vector2
var available_jumps : int
var snap : Vector2

func _ready():
	assert(body != null, "%s has no body set" % [self.name])
	if apply_gravity:
		acceleration.y = GRAVITY
	available_jumps = MAX_JUMPS
	snap = ground_snap

func set_move_direction(_dir: int):
	move_direction = _dir

func move(delta):
	if frozen:
		return
	velocity.x = MOVE_SPEED * move_direction * movement_mask.x
	velocity.y += acceleration.y * delta
	velocity.y *= movement_mask.y
	velocity = body.move_and_slide_with_snap(velocity, snap, floor_normal)
	#velocity = body.move_and_slide(velocity, floor_normal)
	emit_signal("position_updated", body.global_position)

func can_jump() -> bool:
	return available_jumps > 0

func jump(multiplier: float = 1.0) -> void:
	turn_off_snap()
	decrease_jump()
	velocity.y = JUMP_SPEED * multiplier * movement_mask.y
	emit_signal("jumped")

func damp_jump() -> void:
	velocity.y *= JUMP_DAMPING

func decrease_jump() -> void:
	available_jumps = clamp(available_jumps - 1, 0, MAX_JUMPS)

func restore_jumps() -> void:
	available_jumps = MAX_JUMPS

func turn_on_snap() -> void:
	snap = ground_snap

func turn_off_snap() -> void:
	snap = Vector2.ZERO

func freeze(preserve_momentum: bool = true):
	if not preserve_momentum:
		velocity = Vector2.ZERO
	frozen = true

func unfreeze():
	frozen = false
