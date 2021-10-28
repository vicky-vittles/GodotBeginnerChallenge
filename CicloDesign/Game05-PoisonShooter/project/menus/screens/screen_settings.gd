extends GTScreen

signal button_return()

onready var music_slider = $vbox/hbox/vbox/options/music/music_slider
onready var sound_slider = $vbox/hbox/vbox/options/sound/sound_slider

func enter():
	.enter()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	music_slider.value = 100*Settings.music_volume
	sound_slider.value = 100*Settings.sound_volume

func change_music_volume(volume):
	Settings.change_music_volume(volume/100)

func change_sound_volume(volume):
	Settings.change_sound_volume(volume/100)

func _on_return_pressed():
	emit_signal("button_return")
