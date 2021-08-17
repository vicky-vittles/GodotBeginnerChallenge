extends "res://entities/enemies/__enemy/__enemy.gd"

onready var corpse_spawner = $CorpseSpawner

var target

func _ready():
	entity_type = Globals.ENTITIES.ENEMY_ZOMBIE

func generate_random_direction():
	var rand_angle = rand_range(-PI, PI)
	move_direction = Vector2(1,0).rotated(rand_angle)
	rotation.y = -rand_angle-PI/2

func update_move_direction_to_target():
	if target:
		var target_pos = target.global_transform.origin
		var dir_to_target = global_transform.origin.direction_to(target_pos).normalized()
		move_direction = Vector2(dir_to_target.x, dir_to_target.z)
		rotation.y = -move_direction.angle()-PI/2

func update_shoot_direction_to_target():
	if target:
		var target_pos = target.global_transform.origin
		shoot_direction = global_transform.origin.direction_to(target_pos).normalized()

func shoot():
	if has_node("Weapon") and can_shoot:
		var weapon = get_node("Weapon")
		weapon.shoot(shoot_direction, Vector3.ZERO)

func is_alive():
	return health.is_alive
