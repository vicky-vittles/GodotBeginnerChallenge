extends Node2D
signal projectile_exploded(projectile, explosions)

onready var level = $Terrain
onready var players = $Players
onready var projectiles = $Projectiles

var collision_map = []
var current_player_turn : int = 0

func _process(_delta):
	if Input.is_action_just_pressed("sys_exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("sys_reload"):
		get_tree().reload_current_scene()

func get_total_players():
	return players.get_child_count()

func get_player(id: int):
	if id >= 0 and id < get_total_players():
		return players.get_child(id)
	return null


func add_projectile(proj):
	projectiles.add_projectile(proj, collision_map)

func _on_Level_terrain_updated(map):
	collision_map = map

func _on_Projectiles_projectile_exploded(projectile, explosions):
	emit_signal("projectile_exploded", projectile, explosions)
