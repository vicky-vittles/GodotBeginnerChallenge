extends Node

signal wave_started()
signal wave_ended()
signal wave_updated(wave)
signal spawn_enemy(max_speed)

export (float) var WAVE_REST_TIME = 5
export (Dictionary) var ENEMIES_PER_WAVE = {
	1: 10}
export (Dictionary) var ENEMIES_AT_START_PER_WAVE = {
	1: 2}
export (Dictionary) var ENEMIES_SPAWNED_PER_KILL = {
	1: 1}
export (Dictionary) var ENEMY_SPEED = {
	1: 196}
export (bool) var spawn_enemies = true

onready var rest_timer = $RestTimer
onready var enemies_killed_formula = $EnemiesKilledFormula

var current_wave : int = 1

onready var current_enemies_per_wave : int = ENEMIES_PER_WAVE[1]
var current_enemies_at_start_per_wave : int = ENEMIES_AT_START_PER_WAVE[1]
var current_enemies_spawned_per_kill : int = ENEMIES_SPAWNED_PER_KILL[1]
var current_enemy_speed : int = ENEMY_SPEED[1]
var remaining_enemies_to_spawn : int # Amount of enemies remaining for the wave to end

func _ready():
	rest_timer.wait_time = WAVE_REST_TIME
	start_wave()

func start_wave():
	if ENEMIES_PER_WAVE.keys().has(current_wave):
		current_enemies_per_wave = ENEMIES_PER_WAVE[current_wave]
		enemies_killed_formula.expected_value = current_enemies_per_wave
	remaining_enemies_to_spawn = current_enemies_per_wave
	if ENEMIES_AT_START_PER_WAVE.keys().has(current_wave):
		current_enemies_at_start_per_wave = ENEMIES_AT_START_PER_WAVE[current_wave]
	for i in current_enemies_at_start_per_wave:
		spawn_enemy()
	if ENEMIES_SPAWNED_PER_KILL.keys().has(current_wave):
		current_enemies_spawned_per_kill = ENEMIES_SPAWNED_PER_KILL[current_wave]
	if ENEMY_SPEED.keys().has(current_wave):
		current_enemy_speed = ENEMY_SPEED[current_wave]
	emit_signal("wave_started")

func end_wave():
	emit_signal("wave_ended")
	current_wave += 1
	emit_signal("wave_updated", current_wave)
	rest_timer.start()

func spawn_enemy():
	if not spawn_enemies:
		return
	if remaining_enemies_to_spawn > 0:
		remaining_enemies_to_spawn -= 1
		emit_signal("spawn_enemy", current_enemy_speed)

func _on_Entities_enemy_died():
	for i in current_enemies_spawned_per_kill:
		spawn_enemy()
