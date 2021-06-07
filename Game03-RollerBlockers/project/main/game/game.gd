extends Spatial
signal update_level(level_id)
signal level_cleared()
signal level_restart()

func _ready():
	emit_signal("level_restart")
	load_level(Globals.current_level)

func _process(delta):
	if Input.is_action_just_pressed("reload"):
		get_tree().reload_current_scene()


func load_level(id: int):
	if has_node("Level"):
		var old_level = get_node("Level")
		old_level.name = "OldLevel"
		old_level.queue_free()
	var new_level = Globals.LEVELS[Globals.current_level].instance()
	add_child(new_level)
	new_level.connect("player_won", self, "_on_Player_victory")
	new_level.connect("player_restart", self, "_on_Player_restart")
	emit_signal("update_level", id)

func _on_Player_victory():
	Globals.current_level = clamp(Globals.current_level + 1, 0, Globals.NUMBER_OF_LEVELS)
	Globals.max_level_reached = Globals.current_level
	Globals.save_data()
	load_level(Globals.current_level)
	emit_signal("level_cleared")

func _on_Player_restart():
	get_tree().reload_current_scene()
