extends Area2D
class_name GTRandomPointArea2D


func _ready():
	var collision_shapes = 0
	for child in get_children():
		assert(child is CollisionShape2D, "%s has a non-CollisionShape2D child" % [self.name])
		collision_shapes += 1
	assert(collision_shapes > 0, "%s has no CollisionShape2D" % [self.name])
	randomize()


func random_point() -> Vector2:
	var rand_index = randi() % get_child_count()
	var rand_shape = get_child(rand_index)
	var size = 2*rand_shape.shape.extents
	
	var rand_pos_x = posmod(randi(),size.x) - (size.x/2) + global_position.x
	var rand_pos_y = posmod(randi(),size.y) - (size.y/2) + global_position.y
	var rand_pos = Vector2(rand_pos_x, rand_pos_y)
	return rand_pos
