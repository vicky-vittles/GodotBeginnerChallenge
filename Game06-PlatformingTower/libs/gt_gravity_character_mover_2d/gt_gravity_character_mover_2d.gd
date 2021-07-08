extends Node
class_name GTGravityCharacterMover2D

export (NodePath) var body_path
onready var body = get_node(body_path)

export (int) var RUN_SPEED = 256
export (int) var JUMP_HEIGHT = 256
export (float) var JUMP_TIME = 0.5

export (Vector2) var movement_mask = Vector2(1, 1)
export (Vector2) var floor_normal = Vector2.UP
export (bool) var frozen = false

onready var JUMP_SPEED = Utils.jump_speed_formula(JUMP_HEIGHT, JUMP_TIME)
onready var GRAVITY = Utils.gravity_formula(JUMP_HEIGHT, JUMP_TIME)

var move_direction : int
var velocity : Vector2
var acceleration : Vector2

func _ready():
	assert(body != null, "%s has no body set" % [self.name])
	acceleration.y = GRAVITY

func set_move_direction(_dir: int):
	move_direction = _dir

func move(delta):
	if frozen:
		return
	velocity.x = RUN_SPEED * move_direction * movement_mask.x
	velocity.y += acceleration.y * delta
	velocity.y *= movement_mask.y
	velocity = body.move_and_slide(velocity, floor_normal)

func jump() -> void:
	velocity.y = JUMP_SPEED * movement_mask.y

func is_grounded() -> bool:
	return body.is_on_floor()

func freeze(preserve_momentum):
	if not preserve_momentum:
		velocity = Vector2.ZERO
	frozen = true

func unfreeze():
	frozen = false
