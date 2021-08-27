extends Node
class_name GTGravityEntityMover2D

signal position_updated(pos)
signal movement_info(info)
signal jumped()

export (NodePath) var body_path
onready var body = get_node(body_path)

export (int) var MAX_MOVE_SPEED = 256
export (float) var MOVE_ACCELERATION = 0.2
export (float) var MOVE_DECELERATION = 0.2
export (float) var AIR_ACCELERATION = 0.2
export (float) var AIR_DECELERATION = 0.2

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
var move_velocity : Vector2
var velocity : Vector2
var acceleration : Vector2
var impulse : Vector2
var impulse_time : float
var impulse_timer : Timer
var available_jumps : int
var snap : Vector2

func _ready():
	assert(body != null, "%s has no body set" % [self.name])
	if apply_gravity:
		acceleration.y = GRAVITY
	available_jumps = MAX_JUMPS
	snap = ground_snap
	impulse_timer = Timer.new()
	impulse_timer.one_shot = true
	add_child(impulse_timer)

func set_move_direction(_dir: int):
	move_direction = _dir

func move(delta):
	if frozen:
		return
	acceleration.x = MOVE_ACCELERATION if move_direction != 0 else MOVE_DECELERATION
	if abs(velocity.y) > 10:
		acceleration.x = AIR_ACCELERATION if move_direction != 0 else AIR_DECELERATION
	move_velocity.x = lerp(move_velocity.x, MAX_MOVE_SPEED * move_direction, acceleration.x)
	move_velocity.x = clamp(move_velocity.x, -MAX_MOVE_SPEED, MAX_MOVE_SPEED)
	velocity.x = move_velocity.x
	velocity.x = velocity.x + impulse.x*(1.0-get_impulse_completion()) if not impulse_timer.is_stopped() else velocity.x
	velocity.y += acceleration.y * delta
	velocity *= movement_mask
	velocity = body.move_and_slide_with_snap(velocity, snap, floor_normal)
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

func set_impulse(_impulse, _time) -> void:
	impulse = _impulse
	impulse_time = _time
	velocity.y = impulse.y
	impulse_timer.wait_time = impulse_time
	impulse_timer.start()

func get_impulse_completion() -> float:
	return (impulse_timer.wait_time-impulse_timer.time_left)/impulse_timer.wait_time

func freeze(preserve_momentum: bool = true):
	if not preserve_momentum:
		velocity = Vector2.ZERO
	frozen = true

func unfreeze():
	frozen = false