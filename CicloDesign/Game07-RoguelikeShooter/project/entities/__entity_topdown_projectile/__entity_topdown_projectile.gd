extends Entity2D

export (int) var move_speed = 256

onready var body = $Body
onready var damage_hitbox = $Body/DamageHitbox
onready var entity_mover = $Body/EntityMover

var move_direction : Vector2
var bullet_size : int = 1
var bullet_speed : int = 1

func shoot(direction):
	move_direction = direction
	entity_mover.set_velocity(move_speed*move_direction)

func set_bullet_size(_size):
	bullet_size = _size
	body.scale = Globals.BULLET_SIZE_LEVELS[bullet_size]

func set_bullet_speed(_speed):
	bullet_speed = _speed
	move_speed = Globals.BULLET_SPEED_LEVELS[bullet_speed]
