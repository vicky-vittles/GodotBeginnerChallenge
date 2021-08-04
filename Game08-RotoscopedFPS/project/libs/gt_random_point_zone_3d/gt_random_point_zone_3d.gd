extends Spatial
class_name GTRandomPointZone3D

var shapes = []

func _ready():
	for child in get_children():
		if child is CollisionShape:
			assert(child.shape is BoxShape or child.shape is SphereShape, "%s (%s) has a child CollisionShape with a shape that is not supported (please change it to a BoxShape or SphereShape)." % [self.name, self])
			shapes.append(child)
	assert(shapes.size() > 0, "%s (%s) has no CollisionShape child, please add a CollisionShape with either a BoxShape, or a SphereShape." % [self.name, self])

func random_point() -> Vector3:
	var rand_index = randi() % shapes.size()
	var rand_shape = shapes[rand_index]
	if rand_shape.shape is BoxShape:
		return random_point_box(rand_shape)
	elif rand_shape.shape is SphereShape:
		return random_point_sphere(rand_shape)
	return Vector3.ZERO

func random_point_box(shape: CollisionShape) -> Vector3:
	var size = 2*shape.shape.extents
	
	var rand_pos_x = posmod(randi(),size.x) - (size.x/2) + shape.global_position.x
	var rand_pos_y = posmod(randi(),size.y) - (size.y/2) + shape.global_position.y
	var rand_pos_z = posmod(randi(),size.z) - (size.z/2) + shape.global_position.z
	var rand_pos = Vector3(rand_pos_x, rand_pos_y, rand_pos_z)
	return rand_pos

func random_point_sphere(shape: CollisionShape) -> Vector3:
	return Vector3.ZERO
