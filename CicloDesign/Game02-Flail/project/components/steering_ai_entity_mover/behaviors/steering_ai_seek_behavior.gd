extends SteeringAIBehavior
class_name SteeringAISeekBehavior

var steering : Vector2

func move(delta):
	var desired_velocity = (actor.target-actor.body.global_position).normalized() * actor.MAX_SPEED
	steering = desired_velocity - actor.velocity
	steering.clamped(actor.MAX_FORCE)
	steering /= actor.mass
	actor.velocity += steering*delta
