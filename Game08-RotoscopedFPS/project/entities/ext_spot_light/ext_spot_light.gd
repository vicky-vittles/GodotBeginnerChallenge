extends QodotEntity

onready var source = $source

func update_properties():
	if properties["color"]:
		source.light_color = properties["color"]
	if properties["light"]:
		source.light_energy = properties["light"] / 100.0
	if properties["spot_range"]:
		source.spot_range = properties["spot_range"]
	if properties["spot_attenuation"]:
		source.spot_attenuation = properties["spot_attenuation"]
	if properties["spot_angle"]:
		source.spot_angle = properties["spot_angle"]
	if properties["spot_angle_attenuation"]:
		source.spot_angle_attenuation = properties["spot_angle_attenuation"]
