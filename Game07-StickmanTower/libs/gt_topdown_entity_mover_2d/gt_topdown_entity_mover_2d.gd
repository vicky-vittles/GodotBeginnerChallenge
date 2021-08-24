extends Node
class_name GTTopdownEntityMover2D

export (NodePath) var body_path
onready var body = get_node(body_path)

export (int) var RUN_SPEED = 128

export (Vector2) var movement_mask = Vector2(1, 1)
export (bool) var frozen = false

var move_direction : Vector2
var velocity : Vector2

func _ready():
	assert(body != null, "%s has no body set" % [self.name])

func set_move_direction(_dir: Vector2):
	move_direction = _dir

func move(delta):
	if frozen:
		return
	velocity = move_direction * RUN_SPEED
	body.global_position += velocity * delta

func freeze(preserve_momentum: bool = true):
	if not preserve_momentum:
		velocity = Vector2.ZERO
	frozen = true

func unfreeze():
	frozen = false
