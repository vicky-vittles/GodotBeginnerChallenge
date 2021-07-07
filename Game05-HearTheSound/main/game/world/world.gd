extends Node2D

const SOUND_EMITTER = preload("res://entities/sound_emitter/sound_emitter.tscn")

onready var collected_label = $HUD/collected_label
onready var you_win_label = $HUD/root/you_win
onready var camera = $Camera
onready var player = $Player
onready var random_spawn_area = $RandomSpawnArea
onready var cooldown_spawn_timer = $CooldownSpawnTimer

var collected_amount : int = 0
var sound_emitter

func _ready():
	randomize()
	camera.add_target(player)
	spawn_sound_emitter()

func _physics_process(delta):
	if sound_emitter:
		sound_emitter.adjust_volume_by_target(player.global_position)

func spawn_sound_emitter():
	sound_emitter = SOUND_EMITTER.instance()
	add_child(sound_emitter)
	sound_emitter.global_position = random_spawn_area.random_point()
	sound_emitter.connect("collected", self, "_on_SoundEmitter_collected")

func _on_SoundEmitter_collected():
	cooldown_spawn_timer.start()
	collected_amount += 1
	collected_label.apply_text([str(collected_amount)])
	you_win_label.visible = true

func _on_CooldownSpawnTimer_timeout():
	pass
