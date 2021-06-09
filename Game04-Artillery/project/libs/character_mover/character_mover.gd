extends Node
class_name CharacterMover, "res://libs/character_mover/character_mover.svg"

export (int) var MOVE_SPEED = 100
export (int) var JUMP_HEIGHT = 160
export (float) var JUMP_TIME = 1.0
onready var gravity = 2*JUMP_HEIGHT/(JUMP_TIME*JUMP_TIME)
onready var jump_speed = -2*JUMP_HEIGHT/JUMP_TIME

export (bool) var pixel_snap_movement = false
export (int) var pixel_snap_amount = 1

export (Vector2) var gravity_direction = Vector2(0, 1)
export (Vector2) var movement_mask = Vector2(1, 1)
export (int) var ground_snap_amount = 32

export (NodePath) var body_path
onready var body = get_node(body_path)

var move_direction : Vector2
var velocity : Vector2
var acceleration : Vector2
var ground_snap : Vector2

func _ready():
	assert(body != null, "CharacterMover has not been set with a valid body")
	assert(pixel_snap_amount != 0)
	acceleration.y = gravity

func set_move_dir(move_dir: Vector2):
	move_direction = move_dir

func move(delta: float):
	# Apply velocity
	velocity.y += acceleration.y * gravity_direction.y * delta
	velocity.x = move_direction.x * MOVE_SPEED
	velocity *= movement_mask
	
	ground_snap = body.transform.y * ground_snap_amount if abs(body.rotation) < 45 else Vector2(0,0)
	velocity = body.move_and_slide_with_snap(velocity.rotated(body.rotation), ground_snap, -body.transform.y, true)
	velocity = velocity.rotated(-body.rotation)

func _physics_process(delta):
	if pixel_snap_movement:
		body.global_position.x = round(body.global_position.x * pixel_snap_amount) / pixel_snap_amount
		body.global_position.y = round(body.global_position.y * pixel_snap_amount) / pixel_snap_amount
	if body.is_on_floor():
		body.rotation = body.get_floor_normal().angle() + PI/2
