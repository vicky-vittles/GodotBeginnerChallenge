extends Node2D

signal wave_won()
signal wave_lost()

signal duration_time_left_updated(time_left)
signal rest_time_left_updated(time_left)
signal wave_updated(wave)

onready var wave_manager = $WaveManager
onready var player = $Player

func _on_DurationTimer_time_left_updated(time_left):
	emit_signal("duration_time_left_updated", Utils.get_timer_formatted(time_left))

func _on_RestTimer_time_left_updated(time_left):
	emit_signal("rest_time_left_updated", Utils.get_timer_formatted(time_left))

func _on_WaveManager_wave_updated(new_wave):
	emit_signal("wave_updated", new_wave)

func _on_AllEnemiesKilledFormula_succeded():
	emit_signal("wave_won")

func _on_AllEnemiesKilledFormula_failed():
	emit_signal("wave_lost")
