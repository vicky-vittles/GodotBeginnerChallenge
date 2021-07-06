extends Node

export (Resource) var terrain_definition

func _ready():
	randomize()

func generate_random_map(map: Image) -> Image:
	var noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = terrain_definition.map_octaves
	noise.period = terrain_definition.map_period
	noise.persistence = terrain_definition.map_persistence
	
	map.lock()
	for x in map.get_size().x:
		var height = map.get_size().y
		var high = int((noise.get_noise_1d(x)+1) * height * 0.4) + height * 0.08
		for y in high:
			map.set_pixel(x,y, Color.transparent)
	map.unlock()
	return map
