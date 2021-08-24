extends Node2D

signal game_started()
signal player_died()
signal game_over(score, highscore)

onready var points_manager = $PointsManager
onready var black_fade = $UI/root/black_fade
onready var tween = $UI/Tween

func fade_black_out():
	tween.interpolate_property(black_fade, "modulate", Color(0.0, 0.0, 0.0, 0.62), Color(0.0, 0.0, 0.0, 0.0), 0.25)
	tween.start()

func fade_black_in():
	tween.interpolate_property(black_fade, "modulate", Color(0.0, 0.0, 0.0, 0.0), Color(0.0, 0.0, 0.0, 0.62), 0.25)
	tween.start()

func start_game():
	fade_black_out()
	emit_signal("game_started")

func end_game():
	fade_black_in()
	var points = points_manager.current_points
	if points > Globals.highscore:
		Globals.save_score(points)
	emit_signal("game_over", points, Globals.highscore)
