extends Entity2D

const SIZE_LEVELS = {
	1: Vector2(1,1),
	2: Vector2(1.25, 1.25),
	3: Vector2(1.5, 1.5),
	4: Vector2(1.75, 1.75),
	5: Vector2(2, 2)}
const SPEED_LEVELS = {
	1: 640,
	2: 768,
	3: 896,
	4: 1024,
	5: 1280}

export (int) var move_speed = 256

onready var body = $Body
onready var entity_mover = $Body/EntityMover

var move_direction : Vector2
var bullet_size : int = 1
var bullet_speed : int = 1

func shoot(direction):
	move_direction = direction
	entity_mover.set_velocity(move_speed*move_direction)

func set_bullet_size(_size):
	bullet_size = _size
	body.scale = SIZE_LEVELS[bullet_size]

func set_bullet_speed(_speed):
	bullet_speed = _speed
	move_speed = SPEED_LEVELS[bullet_speed]
