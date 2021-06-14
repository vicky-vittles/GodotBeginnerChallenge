extends Node2D
signal terrain_updated(map)

export (Image) var destruction_map

onready var map_generator = $MapGenerator
onready var image_manipulator = $ImageManipulator
onready var image_cache = $ImageCache
onready var terrain = $Graphics/terrain

func _ready():
	var map = map_generator.generate_random_map(destruction_map)
	image_manipulator.set_image(map)
	terrain.get_material().set_shader_param("destruction_map", image_manipulator.texture)

func _on_Projectile_exploded(explosions):
	if explosions and explosions.size() > 0:
		image_manipulator.draw_circles(explosions, Color.transparent)

func _on_cache_updated():
	emit_signal("terrain_updated", image_cache.transparency_cache)