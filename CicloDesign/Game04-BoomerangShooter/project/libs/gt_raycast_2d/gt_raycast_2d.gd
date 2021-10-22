extends RayCast2D
class_name GTRayCast2D

# Is is generally advised to use a raycast
# only for area collisions or body collisions,
# not both at the same time in the same node.
signal grouped_area_collided(area)
signal grouped_area_collision_info(info)
signal grouped_body_collided(body)
signal grouped_body_collision_info(info)

export (Globals.ENTITY_TYPES) var entity_filter = Globals.ENTITY_TYPES.NULL
export (Array, String) var collidable_groups
export (Array, String) var excluded_groups
export (bool) var disable_on_ready = false

var collider_area : Node2D
var collider_body : Node2D

func _ready():
	if disable_on_ready:
		enabled = false

func _physics_process(delta):
	if is_colliding():
		var collider = get_collider()
		var info = {
			"collider": collider,
			"collider_shape": get_collider_shape(),
			"collision_normal": get_collision_normal(),
			"collision_point": get_collision_point()}
		if is_node_collidable(collider):
			if collider is Area2D:
				emit_signal("grouped_area_collided", collider)
				emit_signal("grouped_area_collision_info", info)
				collider_area = collider
			elif collider is PhysicsBody2D:
				emit_signal("grouped_body_collided", collider)
				emit_signal("grouped_body_collision_info", info)
				collider_body = collider
	else:
		collider_area = null
		collider_body = null

func is_node_collidable(node: Node) -> bool:
	for group in excluded_groups:
		if node.is_in_group(group):
			return false
	
	if collidable_groups.empty():
		return true
	
	for group in collidable_groups:
		if node.is_in_group(group):
			return true
	return false
