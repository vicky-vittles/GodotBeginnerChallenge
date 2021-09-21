extends Node2D
class_name GTSoftBodySpring

var k : float
var rest_length : float
var a : Node2D
var b : Node2D

func _init(_k, _rest_length, _a, _b):
	k = _k
	rest_length = _rest_length
	a = _a
	b = _b

func _physics_process(delta):
	var force = b.global_position - a.global_position
	var x = force.length() - rest_length
	force = force.normalized() * k*x
	a.apply_force(force)
	b.apply_force(-force)
