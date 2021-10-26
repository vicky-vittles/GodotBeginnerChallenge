extends GTSteeringBehaviorSeek2D
class_name GTSteeringBehaviorCohesion2D

export (float) var max_cohesion = 32.0

var agents = []

func move(delta):
	if not is_enabled:
		return
	var my_pos = actor.body.global_position
	var center_of_mass = my_pos
	var neighbours_count = 1
	
	for agent in agents:
		var agent_pos = agent.body.global_position
		var dist = my_pos.distance_to(agent_pos)
		if dist < max_cohesion:
			center_of_mass += agent_pos
			neighbours_count += 1
	
	if neighbours_count == 1:
		return
	
	center_of_mass /= neighbours_count
	set_target_pos(center_of_mass)
	.move(delta)

func add_agent(agent): agents.append(agent)
func remove_agent(agent): agents.remove(agents.find(agent))
