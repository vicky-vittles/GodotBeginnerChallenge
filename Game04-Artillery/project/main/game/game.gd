extends Node2D

onready var level = $Level
onready var projectiles = $Projectiles

var collision_map = []

func _process(_delta):
	if Input.is_action_just_pressed("sys_exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("sys_reload"):
		get_tree().reload_current_scene()

func add_projectile(proj):
	projectiles.add_projectile(proj, collision_map)

func _on_Level_terrain_updated(map):
	collision_map = map
