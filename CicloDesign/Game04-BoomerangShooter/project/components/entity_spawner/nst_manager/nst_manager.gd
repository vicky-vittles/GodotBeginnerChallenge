# NSTManager
# Currently supports only one type of spawned enemy
extends Node2D

signal spawned_enemy(info)
signal enemy_died()
signal updated_wave(wave)
signal updated_properties(dict)

const STR_SCREEN_ENEMIES = "screen_enemies"
const STR_WAVE_ENEMIES = "wave_enemies"
const STR_TIME_BETWEEN_WAVES = "time_between_waves"
const STR_REPLACEMENT_TIME = "replacement_time"

export (Dictionary) var enemy_properties
export (Dictionary) var wave_properties = {
	STR_SCREEN_ENEMIES: [2],
	STR_WAVE_ENEMIES: [5],
	STR_TIME_BETWEEN_WAVES: [3.0],
	STR_REPLACEMENT_TIME: [1.0]}
export (int) var initial_wave : int = 1
export (int) var max_waves : int = 1
export (bool) var debug_mode = false

var enemies_spawned : int # The number of enemies that have been spawned in this current wave
var enemies_killed : int # The number of enemies that have been killed in this current wave
var enemy_spawn_queue : int # The number of enemies waiting in queue for being spawned
onready var current_wave : int = initial_wave

var screen_enemies : int
var wave_enemies : int
onready var between_wave_timer = $BetweenWavesTimer
onready var replacement_timer = $ReplacementTimer

func _ready(): _set_variables()
func _physics_process(delta): check_advance_wave()
func start(): _set_wave(initial_wave)
func can_spawn() -> bool: return enemies_spawned < get_wave_property(STR_WAVE_ENEMIES)
func get_enemy_property(name: String): return _get_enemy_property(name, current_wave)
func get_wave_property(name: String): return _get_wave_property(name, current_wave)
func has_wave_property(name: String): return _has_wave_property(name, current_wave)

func check_advance_wave():
	if enemies_killed >= wave_enemies and between_wave_timer.is_stopped():
		between_wave_timer.start()

func advance_wave():
	if current_wave < max_waves:
		_set_wave(current_wave+1)

func spawn_enemy():
	var info = {}
	for key in enemy_properties.keys():
		info[key] = get_enemy_property(key)
	enemies_spawned += 1
	emit_signal("spawned_enemy", info)
	#if debug_mode: print("spawned enemy")

func _set_wave(_wave):
	current_wave = _wave
	_set_variables()
	for i in screen_enemies:
		spawn_enemy()
	emit_signal("updated_wave", current_wave)
	if debug_mode: print("current_wave: %s" % [current_wave])

func _set_variables():
	enemies_spawned = 0
	enemies_killed = 0
	enemy_spawn_queue = 0
	screen_enemies = get_wave_property(STR_SCREEN_ENEMIES) if has_wave_property(STR_SCREEN_ENEMIES) else screen_enemies
	wave_enemies = get_wave_property(STR_WAVE_ENEMIES) if has_wave_property(STR_WAVE_ENEMIES) else wave_enemies
	between_wave_timer.wait_time = get_wave_property(STR_TIME_BETWEEN_WAVES) if has_wave_property(STR_TIME_BETWEEN_WAVES) else between_wave_timer.wait_time
	replacement_timer.wait_time = get_wave_property(STR_REPLACEMENT_TIME) if has_wave_property(STR_REPLACEMENT_TIME) else replacement_timer.wait_time
	emit_signal("updated_properties", wave_properties)

func _get_enemy_property(name: String, wave: int):
	if wave > 0 and enemy_properties.has(name) and enemy_properties[name].size() >= wave:
		return enemy_properties[name][wave-1]

func _get_wave_property(name: String, wave: int):
	if wave > 0 and wave_properties.has(name) and wave_properties[name].size() >= wave:
		return wave_properties[name][wave-1]

func _has_wave_property(name: String, wave: int) -> bool:
	if wave > 0 and wave_properties.has(name) and wave_properties[name].size() >= wave:
		return true
	return false

func _on_EntitySpawner_spawned_entity(entity):
	assert(entity.has_signal("died"), "%s NSTManager tried to utilize an entity %s that does not contain the 'died' signal" % [self.name, entity.name])
	entity.connect("died", self, "_on_entity_died")

func _on_entity_died():
	enemies_killed += 1
	enemy_spawn_queue += 1
	if can_spawn() and replacement_timer.is_stopped():
		replacement_timer.start()
	if debug_mode:
		print(enemies_killed)
	emit_signal("enemy_died")

func _on_ReplacementTimer_timeout():
	enemy_spawn_queue -= 1
	if can_spawn(): spawn_enemy()
	if enemy_spawn_queue > 0:
		replacement_timer.start()
