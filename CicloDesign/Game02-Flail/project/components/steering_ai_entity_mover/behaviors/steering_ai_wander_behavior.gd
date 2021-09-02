extends SteeringAIBehavior
class_name SteeringAIWanderBehavior

export (int) var circle_distance = 32
export (int) var circle_radius = 8
export (float) var angle_change = 5

var wander_angle : float

func move(delta):
	var direction = actor.velocity.normalized()
	var circle_center = direction*circle_distance
	
	var displacement = Vector2.RIGHT * circle_radius
	displacement = displacement.rotated(deg2rad(wander_angle))
	
	wander_angle += (randf()*2-1)*angle_change
	
	var wander_force = circle_center + displacement
	wander_force = wander_force.clamped(actor.MAX_FORCE)
	actor.velocity += wander_force*delta
