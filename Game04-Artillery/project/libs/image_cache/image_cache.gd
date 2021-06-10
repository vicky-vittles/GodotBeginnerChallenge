extends Node
class_name ImageCache

signal cache_updated()

var transparency_cache = []

func _on_image_updated(image):
	transparency_cache = []
	image.lock()
	var size = image.get_size()
	for y in size.y:
		var row = []
		for x in size.x:
			var color = image.get_pixel(x,y)
			row.append((color.a == 1.0))
		transparency_cache.append(row)
	image.unlock()
	emit_signal("cache_updated")
