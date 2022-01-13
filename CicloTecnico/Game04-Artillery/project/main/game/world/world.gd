extends Node2D
signal update_time(timer)
signal update_kills(kills)

signal camera_focus_on_player(player)
signal projectile_exploded(projectile, explosions)
signal explosion_faded()

signal player_died()
signal update_game_over_info(kills, time)

onready var enemy_spawn_manager = $EnemySpawnManager
onready var random_spawn_area = $EnemySpawnManager/RandomSpawnArea
onready var level = $Terrain
onready var players = $Players
onready var enemies = $Enemies
onready var projectiles = $Projectiles

var collision_map = []
var collision_map_size : Vector2
var current_player_turn : int = 0

var kills : int = 0
var timer : float = 0.0
var player_dead : bool = false

func _process(_delta):
	if Input.is_action_just_pressed("sys_exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("sys_reload"):
		get_tree().reload_current_scene()

func _physics_process(delta):
	if not player_dead:
		timer += delta
		emit_signal("update_time", timer)

func get_total_players():
	return players.get_child_count()

func get_main_player():
	return players.get_main_player()

func get_player(id: int):
	if id >= 0 and id < get_total_players():
		return players.get_child(id)
	return null

func get_current_player():
	return get_player(current_player_turn)


func add_projectile(proj):
	projectiles.add_projectile(proj, collision_map)

func _on_Level_terrain_updated(map):
	collision_map = map

func _on_Projectiles_projectile_exploded(projectile, explosions):
	emit_signal("projectile_exploded", projectile, explosions)

func _on_EnemySpawnManager_enemy_died():
	kills += 1
	emit_signal("update_kills", kills)

func _on_Player_died():
	if not player_dead:
		emit_signal("player_died")
		emit_signal("update_game_over_info", kills, timer)
	player_dead = true
