extends Node2D

signal enemy_died()

const ENEMY_BOMBER = preload("res://entities/enemies/enemy_bomber/enemy_bomber.tscn")

export (int) var STARTING_ENEMIES = 3 # Number of enemies already spawned
const PROGRESSION = {
	0: [5.0, 1],
	15.0: [4.0, 1],
	30.0: [3.0, 1],
	45.0: [2.0, 1],
	60.0: [1.0, 1],
	75.0: [1.0, 2]
}

onready var world = get_parent()
onready var spawn_timer = $SpawnTimer
onready var timer = $Timer
onready var random_spawn_area = $RandomSpawnArea

var enemies_per_spawn : int = 1

func initial_spawn():
	spawn_timer.start()
	timer.start()
	for i in STARTING_ENEMIES:
		spawn_enemy()

func _physics_process(_delta):
	if not timer.is_stopped():
		var time_passed = timer.wait_time - timer.time_left
		for level in PROGRESSION:
			if time_passed <= PROGRESSION[level][0]:
				enemies_per_spawn = PROGRESSION[level][1]

# Spawn single enemy
func spawn_enemy():
	var new_enemy = ENEMY_BOMBER.instance()
	world.enemies.add_child(new_enemy)
	new_enemy.connect("died", self, "emit_signal", ["enemy_died"])
	
	var rand_position = random_spawn_area.random_point()
	new_enemy.global_position = rand_position
