extends Node2D

export (float) var particles_gravity = 1000
export (int) var links = 20
export (int) var rope_rest_length = 200
export (float) var rope_k_factor = 1.0

var particles = []
var springs = []
var lines = []

func _ready():
	for i in links:
		var new_particle = GTSoftBodyParticle.new(global_position + Vector2(0, 1)*i*rope_rest_length/links + Vector2(1, 0)*i*20.0)
		new_particle.gravity = particles_gravity
		new_particle.collision_layer = 4
		new_particle.collision_mask = 2
		new_particle.name = "p%s" % [i]
		particles.append(new_particle)
		add_child(new_particle)
	for i in range(0, links-1):
		var a = particles[i]
		var b = particles[i+1]
		var new_spring = GTSoftBodySpring.new(rope_k_factor, rope_rest_length/(links-1), a, b)
		new_spring.name = "s%s" % [i]
		springs.append(new_spring)
		add_child(new_spring)
	for i in springs.size():
		var new_line = Line2D.new()
		new_line.width = 8
		new_line.name = "l%s" % [i]
		lines.append(new_line)
		add_child(new_line)

func _physics_process(delta):
	particles[0].global_position = get_viewport().get_mouse_position()
	for i in lines.size():
		lines[i].points = [particles[i].global_position-global_position, particles[i+1].global_position-global_position]
