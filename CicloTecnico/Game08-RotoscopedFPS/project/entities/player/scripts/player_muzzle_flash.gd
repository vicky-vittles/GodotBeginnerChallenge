extends Light

export (float) var max_light_energy = 1.0
export (float) var time_to_fade = 0.06

onready var tween = $Tween

func start_flash():
	light_energy = max_light_energy

func stop_flash():
	tween.interpolate_property(self, "light_energy", max_light_energy, 0, time_to_fade)
	tween.start()
