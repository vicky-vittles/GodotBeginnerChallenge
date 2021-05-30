extends CanvasLayer

onready var points_p1 = $root/points_p1
onready var points_p2 = $root/points_p2
onready var match_timer = $root/scale_pivot/match_timer

func _on_P1_update_points(total_points):
	points_p1.replace_text([total_points])

func _on_P2_update_points(total_points):
	points_p2.replace_text([total_points])

func _on_MatchTimer_update_time(time: int):
	var seconds = int(time % 60)
	var minutes = int(time / 60)
	if minutes > 0:
		match_timer.text = "%s:%s" % [minutes, str(seconds).pad_zeros(2)]
	else:
		match_timer.text = str(seconds).pad_zeros(2)
