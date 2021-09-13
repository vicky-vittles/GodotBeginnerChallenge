extends LevelLoader

signal player_died()

func _on_level_started():
	if level:
		level.connect("player_died", self, "emit_signal", ["player_died"])
