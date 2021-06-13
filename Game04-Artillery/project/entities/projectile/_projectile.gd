extends Node2D
signal exploded(proj)

export (int) var PIXEL_COLLISION_RADIUS = 2
export (int) var MAX_EXPLOSIONS = 1
export (int) var EXPLOSION_RADIUS = 50

onready var projectile_mover = $ProjectileMover

var soldier_owner
var map_limit
var collision_map

func init(angle, charge, _soldier_owner):
	soldier_owner = _soldier_owner
	map_limit = soldier_owner.collision_map[0].size()
	projectile_mover.fire(angle, charge)

func exploded():
	emit_signal("exploded", self)
	effect()

func effect():
	pass
