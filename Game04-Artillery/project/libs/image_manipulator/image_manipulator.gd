extends Node
class_name ImageManipulator

signal image_updated(image)

var image
var texture

func set_image(img):
	image = Image.new()
	if image.get_size() != Vector2.ZERO:
		image.lock()
	image.copy_from(img)
	image.unlock()
	texture = ImageTexture.new()
	set_texture()
	emit_signal("image_updated", image)

func set_texture():
	texture.create_from_image(image)

func get_pixels() -> Array:
	if not image:
		return []
	
	image.lock()
	var pixels = []
	for y in image.get_size().y:
		for x in image.get_size().x:
			var pixel_pos = Vector2(x,y)
			pixels.append(image.get_pixelv(pixel_pos))
	
	return pixels


func draw_circle(c_pos: Vector2, c_radius: int, color: Color):
	if not image:
		return
	
	# First, lock image to access pixels
	image.lock()
	
	# Put all pixels to color in a list
	var pixels_to_color = []
	for y in image.get_size().y:
		for x in image.get_size().x:
			var pixel_pos = Vector2(x,y)
			var dist_squared = pixel_pos.distance_squared_to(c_pos)
			if dist_squared <= c_radius*c_radius:
				pixels_to_color.append(pixel_pos)
	
	# Color those pixels
	for i in pixels_to_color.size():
		var pixel_pos = Vector2(pixels_to_color[i].x, pixels_to_color[i].y)
		image.set_pixelv(pixel_pos, color)
	
	# Finish up by unlocking image
	image.unlock()
	set_texture()
	emit_signal("image_updated", image)
