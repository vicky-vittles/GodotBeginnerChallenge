extends GTScreen

signal set_scores(score, highscore)
signal button_play_again()

onready var score_label = $vbox/hbox/vbox/scores/score_label
onready var highscore_label = $vbox/hbox/vbox/scores/highscore_label

func _on_InitialMenu_set_scores(score, highscore):
	emit_signal("set_scores", score, highscore)

func _on_GameOverScreen_set_scores(score, highscore):
	score_label.apply_text_simple(score)
	highscore_label.apply_text_simple(highscore)
