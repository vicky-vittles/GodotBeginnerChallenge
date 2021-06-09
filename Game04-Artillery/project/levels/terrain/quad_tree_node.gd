extends StaticBody2D
class_name QuadTreeNode, "res://levels/terrain/quad-tree-node.svg"

var boundary : Rect2
var level : int
var collision_shape


func set_boundary(_level: int, _boundary):
	boundary = _boundary
	collision_shape = CollisionShape2D.new()
	add_child(collision_shape)
	collision_shape.set_shape(Globals.shapes_dict[_level])
	collision_shape.name = "shape"


func create(_level: int, pixels: Array):
	level = _level
	if not needs_split(pixels):
		return
	split(pixels)


func needs_split(pixels: Array) -> bool:
	var color_to_compare = pixels[0]
	for i in pixels.size()-1:
		var pixel_color = pixels[i+1]
		if not color_to_compare.is_equal_approx(pixel_color):
			return true
	return false


func split(pixels: Array):
	if has_node("shape"):
		remove_child(get_node("shape"))
		collision_shape = null
	
	var rects = [
		Rect2(Vector2(0, 0), boundary.size/2),
		Rect2(Vector2(boundary.size.x/2, 0), boundary.size/2),
		Rect2(Vector2(0, boundary.size.y/2), boundary.size/2),
		Rect2(boundary.size/2, boundary.size/2)]
	
	var new_pixels = {
		0: [],
		1: [],
		2: [],
		3: []}
	var length = sqrt(pixels.size())
	var half_length = length/2
	for i in pixels.size():
		var pos = Vector2(int(i) % int(length), int(i/length))
		var pos_d = pos - half_length*Vector2(1,1)
		
		var x_left = sign(pos_d.x) == -1
		var y_up = sign(pos_d.y) == -1
		
		var index
		if x_left and y_up:
			index = 0
		elif not x_left and y_up:
			index = 1
		elif x_left and not y_up:
			index = 2
		elif not x_left and not y_up:
			index = 3
		new_pixels[index].append(pixels[i])
	
	for i in rects.size():
		var new_node = load(get_script().resource_path).new()
		add_child(new_node)
		new_node.name = "%s%s" % [level + 1, i]
		new_node.global_position = rects[i].position + rects[i].size/2
		new_node.set_boundary(level + 1, rects[i])
		new_node.create(level + 1, new_pixels[i])
