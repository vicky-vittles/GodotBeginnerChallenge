extends Node
class_name EntityMover

export (int) var move_speed = 100
export (int) var jump_height = 160
export (float) var jump_time = 1.0
onready var gravity = 2*jump_height/(jump_time*jump_time)
onready var jump_speed = -2*jump_height/jump_time

export (bool) var enable_pixel_snap_movement = false
export (int) var pixel_snap_amount = 1

export (NodePath) var body_path
onready var body = get_node(body_path)

var direction : Vector2
var acceleration : Vector2
var velocity : Vector2

func _ready():
	acceleration.y = gravity

func set_direction(dir: Vector2):
	direction = dir

func move(delta: float):
	velocity.y += acceleration.y * direction.y * delta
	velocity.x = move_speed * direction.x
	
	if body is KinematicBody2D:
		velocity = body.move_and_slide(velocity)
	elif body is Area2D:
		body.global_position += velocity * delta

func _physics_process(delta):
	if enable_pixel_snap_movement:
		body.global_position.x = round(body.global_position.x * pixel_snap_amount) / pixel_snap_amount
		body.global_position.y = round(body.global_position.y * pixel_snap_amount) / pixel_snap_amount
