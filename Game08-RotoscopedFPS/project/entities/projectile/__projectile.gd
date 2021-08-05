extends KinematicBody

export (Vector2) var move_direction = Vector2.ZERO
onready var entity_mover = $EntityMover
var damage : int

func _ready():
	if move_direction == Vector2.ZERO:
		entity_mover.freeze(false)

func _physics_process(delta):
	entity_mover.set_move_direction(move_direction)
	entity_mover.move(delta)

func shoot(_dir: Vector2, _damage: int):
	move_direction = _dir
	damage = _damage
	entity_mover.unfreeze()
