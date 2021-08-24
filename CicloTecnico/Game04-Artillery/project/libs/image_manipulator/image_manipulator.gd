extends Node
class_name ImageManipulator

signal image_updated(image)

var image
var texture
var thread

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


func draw_circles(circles: Array, color: Color):
	if not image:
		return
	
	var dup_image = image.duplicate()
	
	# Put all pixels to color in a list
	var info = {
		"circles": circles,
		"color": color,
		"image_to_draw": dup_image}
	thread = Thread.new()
	thread.start(self, "draw_circles_job", info)

func draw_circles_job(info):
	var circles = info["circles"]
	var color = info["color"]
	var image_to_draw = info["image_to_draw"]
	
	# First, lock image to access pixels
	image_to_draw.lock()
	
	var pixels_to_color = []
	for y in image_to_draw.get_size().y:
		for x in image_to_draw.get_size().x:
			var pixel_pos = Vector2(x,y)
			for circle in circles:
				var c_pos = circle[0]
				var c_radius = circle[1]
				var dist_squared = pixel_pos.distance_squared_to(c_pos)
				if dist_squared <= c_radius*c_radius:
					pixels_to_color.append(pixel_pos)
					break
	
	# Color those pixels
	for i in pixels_to_color.size():
		var pixel_pos = Vector2(pixels_to_color[i].x, pixels_to_color[i].y)
		image_to_draw.set_pixelv(pixel_pos, color)
	
	# Finish up by unlocking image
	image_to_draw.unlock()
	call_deferred("draw_circles_done")
	return image_to_draw

func draw_circles_done():
	image.copy_from(thread.wait_to_finish())
	set_texture()
	emit_signal("image_updated", image)
