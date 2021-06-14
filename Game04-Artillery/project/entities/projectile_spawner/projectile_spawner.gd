extends Node2D

export (NodePath) var soldier_owner_path
onready var soldier_owner = get_node(soldier_owner_path)

var selected_weapon

func spawn(angle, charge, dir):
	var projectile = selected_weapon.instance()
	Globals.get_game().add_projectile(projectile)
	projectile.global_position = global_position
	var dir_angle = Vector2(dir,0).rotated(dir*angle).angle()
	projectile.init(dir_angle, charge, soldier_owner)

func switch_weapon(weapon):
	selected_weapon = weapon
