extends Button

signal collect()

export (float) var cooldown_time = 30.0
export (Color) var progress_color = Color.white

onready var progress = $progress
onready var cooldown_timer = $cooldown_timer
onready var tween = $Tween

func _ready():
	progress.rect_color = progress_color
	cooldown_timer.wait_time = cooldown_time

func _on_button_pressed():
	disabled = true
	tween.interpolate_property(progress, "value", 100.0, 0.0, cooldown_time)
	tween.start()
	emit_signal("collect")

func _on_cooldown_timer_timeout():
	disabled = false
