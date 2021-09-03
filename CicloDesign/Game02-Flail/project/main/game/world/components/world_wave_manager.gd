extends Node

signal wave_started()
signal rest_started()
signal rest_ended()
signal wave_ended(enemies_killed)
signal wave_updated(new_wave)

signal enemy_spawn_timeout(max_speed)

export (float) var WAVE_REST_TIME = 10
export (float) var LAST_SPAWN_TIME = 10
export (Dictionary) var WAVE_DURATIONS = {
	1: 30}
export (Dictionary) var ENEMY_PER_WAVE = {
	1: 10}
export (Dictionary) var ENEMY_SPEED = {
	1: 128}

onready var duration_timer = $DurationTimer
onready var rest_timer = $RestTimer
onready var spawn_timer = $SpawnTimer
onready var enemies_killed = $EnemiesKilled
onready var all_enemies_killed_formula = $AllEnemiesKilledFormula

var current_wave_duration : int
var current_wave : int = 1

var current_enemy_per_wave : int
var current_enemy_speed : int
var current_enemy_spawn_time : float
var enemies_to_spawn : int

func _ready():
	current_wave_duration = WAVE_DURATIONS[current_wave]
	duration_timer.wait_time = current_wave_duration
	current_enemy_per_wave = ENEMY_PER_WAVE[current_wave]
	all_enemies_killed_formula.expected_value = current_enemy_per_wave
	current_enemy_speed = ENEMY_SPEED[current_wave]
	rest_timer.wait_time = WAVE_REST_TIME
	update_wave_info()
	start_wave()

func update_wave_info():
	current_enemy_spawn_time = (current_wave_duration-LAST_SPAWN_TIME)/current_enemy_per_wave
	spawn_timer.wait_time = current_enemy_spawn_time

func start_wave():
	emit_signal("wave_started")
	emit_signal("wave_updated", current_wave)
	enemies_to_spawn = current_enemy_per_wave
	duration_timer.start()
	spawn_timer.start()

func end_wave():
	rest_timer.start()
	emit_signal("wave_ended", enemies_killed.current_points)

func advance_wave():
	current_wave += 1
	if WAVE_DURATIONS.keys().has(current_wave):
		current_wave_duration = WAVE_DURATIONS[current_wave]
		duration_timer.wait_time = current_wave_duration
	if ENEMY_PER_WAVE.keys().has(current_wave):
		current_enemy_per_wave = ENEMY_PER_WAVE[current_wave]
		all_enemies_killed_formula.expected_value = current_enemy_per_wave
	if ENEMY_SPEED.keys().has(current_wave):
		current_enemy_speed = ENEMY_SPEED[current_wave]
	update_wave_info()
	start_wave()

func _on_DurationTimer_timeout():
	end_wave()
	emit_signal("rest_started")

func _on_RestTimer_timeout():
	emit_signal("rest_ended")
	advance_wave()

func _on_SpawnTimer_timeout():
	if enemies_to_spawn > 0:
		enemies_to_spawn -= 1
		spawn_timer.start()
		emit_signal("enemy_spawn_timeout", current_enemy_speed)
