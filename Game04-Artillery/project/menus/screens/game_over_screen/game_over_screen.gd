extends GTScreen

signal button_play_again()
signal button_quit()

onready var kills_label = $vbox/hbox/vbox/scores/info/kills_label
onready var time_label = $vbox/hbox/vbox/scores/info/time_label

func set_info(kills, time):
	kills_label.apply_text([str(kills)])
	time_label.apply_text([Utils.get_timer_formatted(time)])
