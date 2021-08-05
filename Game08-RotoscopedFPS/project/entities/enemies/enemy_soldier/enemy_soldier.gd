extends "res://entities/enemies/__enemy.gd"

func generate_random_direction():
	var rand_angle = rand_range(-PI, PI)
	move_direction = Vector2(1,0).rotated(rand_angle)
	rotation.y = -rand_angle-PI/2

func shoot():
	if has_node("Weapon"):
		var weapon = get_node("Weapon")
		weapon.shoot(-transform.basis.z, Vector3.ZERO)
