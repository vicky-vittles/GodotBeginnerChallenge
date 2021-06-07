extends Spatial
signal entered_win_zone()
signal entered_lose_zone()
signal exited_level_zone()

onready var input_controller = $InputController
onready var body = $body

func _on_Triggers_area_entered(area):
	if area.is_in_group("win_zone"):
		emit_signal("entered_win_zone")
	if area.is_in_group("lose_zone"):
		emit_signal("entered_lose_zone")

func _on_Triggers_area_exited(area):
	if area.is_in_group("level_zone"):
		emit_signal("exited_level_zone")
