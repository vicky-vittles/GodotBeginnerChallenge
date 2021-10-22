extends GTSteeringBehavior2D
class_name GTSteeringBehaviorAvoidance2D

export (NodePath) var raycast_path
export (float) var max_avoid_force = 8.0

var raycast : GTRayCast2D
var collider : Node2D setget _set_collider

func _ready():
	raycast = get_node(raycast_path)
	assert(raycast != null, "Error initializing GTSteeringBehaviorAvoidance2D: 'raycast' property is null")
	assert(!raycast.collide_with_areas or !raycast.collide_with_bodies, "Error initializing GTSteeringBehaviorAvoidance2D: 'raycast' is configured to collide with both areas and bodies. It should have only one type of collision")
	if raycast.collide_with_areas:
		raycast.connect("grouped_area_collided", self, "_set_collider")
	elif raycast.collide_with_bodies:
		raycast.connect("grouped_body_collided", self, "_set_collider")

func _set_collider(_value):
	collider = _value

func move(delta):
	if not is_instance_valid(collider):
		collider = null
	if collider:
		var ahead = actor.body.global_position + actor.body.transform.x*raycast.cast_to
		var avoidance_force = ahead - collider.global_position
		avoidance_force = avoidance_force.clamped(max_avoid_force)
		avoidance_force /= actor.mass
		actor.velocity += avoidance_force * delta
