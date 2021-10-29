extends GTSteeringBehavior2D
class_name GTSteeringBehaviorSeparation2D

export (float) var max_force = 64.0
export (float) var min_separation = 32.0

var agents = []

func move(delta):
	if not is_enabled:
		return
	var my_pos = actor.body.global_position
	var total_force = Vector2.ZERO
	var neighbours_count = 0
	
	for agent in agents:
		var agent_pos = agent.body.global_position
		var dist = my_pos.distance_to(agent_pos)
		if dist < min_separation and dist > 0:
			var agent_radius = dist / min_separation
			var push_force = agent_pos-my_pos
			total_force += push_force / agent_radius
			neighbours_count += 1
	
	if neighbours_count == 0:
		return
	
	total_force /= neighbours_count
	total_force = total_force.clamped(max_force)
	actor.velocity += total_force*delta

func add_agent(agent): agents.append(agent)
func remove_agent(agent): agents.remove(agents.find(agent))
