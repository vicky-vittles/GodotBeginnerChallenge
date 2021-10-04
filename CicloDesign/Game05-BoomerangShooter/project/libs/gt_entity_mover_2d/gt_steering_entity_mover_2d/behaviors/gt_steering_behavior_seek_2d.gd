extends GTSteeringBehavior2D
class_name GTSteeringBehaviorSeek2D

var steering : Vector2

func move(delta):
	var desired_velocity = (actor.target.global_position-actor.body.global_position).normalized() * actor.max_speed
	steering = desired_velocity - actor.velocity
	steering.clamped(actor.max_force)
	steering /= actor.mass
	actor.velocity += steering*delta
