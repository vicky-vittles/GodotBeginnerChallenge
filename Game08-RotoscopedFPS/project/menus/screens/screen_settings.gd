extends GTScreen

signal button_back()

export (Texture) var music_on
export (Texture) var music_off
export (Texture) var sound_on
export (Texture) var sound_off

onready var music_icon = $vbox/hbox/vbox/buttons/sliders/music/icon_vbox/icon
onready var sound_icon = $vbox/hbox/vbox/buttons/sliders/sound/icon_vbox/icon
onready var music_slider = $vbox/hbox/vbox/buttons/sliders/music/slider_vbox/slider
onready var sound_slider = $vbox/hbox/vbox/buttons/sliders/sound/slider_vbox/slider

func load_settings():
	music_slider.value = 100*Settings.music_volume
	sound_slider.value = 100*Settings.sound_volume

func change_music_volume(volume):
	if volume == 0.0:
		music_icon.texture = music_off
	else:
		music_icon.texture = music_on
	Settings.change_music_volume(volume/100)

func change_sound_volume(volume):
	if volume == 0.0:
		sound_icon.texture = sound_off
	else:
		sound_icon.texture = sound_on
	Settings.change_sound_volume(volume/100)
