extends Node2D
signal exploded(proj)

export (int) var PIXEL_RADIUS = 2
export (int) var MAX_EXPLOSIONS = 1
export (int) var EXPLOSION_RADIUS = 50

onready var projectile_mover = $ProjectileMover

var collision_map

func init(angle, charge):
	projectile_mover.fire(angle, charge)

func exploded():
	emit_signal("exploded", self)
