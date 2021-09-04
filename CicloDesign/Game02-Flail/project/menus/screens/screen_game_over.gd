extends GTScreen

signal button_play_again()
signal button_quit()

onready var score_label = $vbox/hbox/vbox/VBoxContainer/score_label

func load_score():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	var score = Globals.current_score
	score_label.apply_text_simple(score)

func _on_play_again_button_pressed():
	emit_signal("button_play_again")

func _on_quit_pressed():
	emit_signal("button_quit")
