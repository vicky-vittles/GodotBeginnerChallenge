extends KinematicBody

export (Vector2) var move_direction = Vector2.ZERO

onready var damage_hitbox = $DamageHitbox
onready var entity_mover = $EntityMover
var damage : int

func _ready():
	if move_direction == Vector2.ZERO:
		entity_mover.freeze(false)

func _physics_process(delta):
	entity_mover.set_move_direction(move_direction)
	entity_mover.move(delta)

func set_groups(collidable_groups, excluded_groups):
	damage_hitbox.collidable_groups = collidable_groups
	damage_hitbox.excluded_groups = excluded_groups

func shoot(_dir: Vector3, _damage: int):
	move_direction = Vector2(_dir.x, _dir.z)
	damage = _damage
	entity_mover.unfreeze()

func _on_DamageHitbox_grouped_area_entered(area):
	if area.has_method("hurt"):
		area.hurt(damage)
		call_deferred("queue_free")
