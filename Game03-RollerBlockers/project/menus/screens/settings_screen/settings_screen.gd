extends "res://libs/menus/screens/_screen.gd"
signal button_return()

onready var music_slider = $vbox/hbox/vbox/options/music/center/music_volume
onready var sound_slider = $vbox/hbox/vbox/options/sound/center/sound_volume
onready var music_label = $vbox/hbox/vbox/options/music/label
onready var sound_label = $vbox/hbox/vbox/options/sound/label

func load_settings():
	music_slider.value = Settings.music_volume * 100
	sound_slider.value = Settings.sound_volume * 100
	music_label.text = "Music (%s)" % str(int(music_slider.value))
	sound_label.text = "Sound (%s)" % str(int(sound_slider.value))

func set_settings():
	Settings.change_music_volume(music_slider.value / 100)
	Settings.change_sound_volume(sound_slider.value / 100)

func _on_music_volume_value_changed(value):
	music_label.text = "Music (%s)" % str(int(value))
	set_settings()

func _on_sound_volume_value_changed(value):
	sound_label.text = "Sound (%s)" % str(int(value))
	set_settings()
