extends GTMenu

signal set_scores(score, highscore)
signal game_started()
signal player_died()

func set_scores(score: int, highscore: int):
	emit_signal("set_scores", score, highscore)
