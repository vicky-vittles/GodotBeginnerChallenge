extends QodotEntity

onready var source = $source

func update_properties():
	if properties["color"]:
		source.light_color = properties["color"]
	if properties["light"]:
		source.light_energy = properties["light"] / 100.0
