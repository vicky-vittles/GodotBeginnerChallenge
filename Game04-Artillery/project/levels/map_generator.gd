extends Node

export (int) var map_octaves = 2
export (float) var map_period = 180.0
export (float) var map_persistence = 0.8

func generate_random_map(map: Image) -> Image:
	randomize()
	var noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = map_octaves
	noise.period = map_period
	noise.persistence = map_persistence
	
	map.lock()
	for x in map.get_size().x:
		var height = map.get_size().y
		var high = int((noise.get_noise_1d(x)+1) * height * 0.4) + height * 0.08
		for y in high:
			map.set_pixel(x,y, Color.transparent)
	map.unlock()
	return map
