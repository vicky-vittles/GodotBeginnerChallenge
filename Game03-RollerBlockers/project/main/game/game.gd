extends Spatial

func _ready():
	load_level(Globals.current_level)

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
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

func _on_Player_victory():
	Globals.current_level = clamp(Globals.current_level + 1, 0, Globals.NUMBER_OF_LEVELS)
	load_level(Globals.current_level)

func _on_Player_restart():
	get_tree().reload_current_scene()
