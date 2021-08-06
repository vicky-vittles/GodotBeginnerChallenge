extends QodotEntity

onready var source = $source

func update_properties():
	if properties["color"]:
		source.light_color = properties["color"]
	if properties["light"]:
		source.light_energy = properties["light"] / 100.0
	if properties["omni_range"]:
		source.omni_range = properties["omni_range"]
	if properties["omni_attenuation"]:
		source.omni_attenuation = properties["omni_attenuation"]
