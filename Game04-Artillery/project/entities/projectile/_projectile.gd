extends Node2D
signal exploded(proj)

export (int) var PIXEL_COLLISION_RADIUS = 2
export (int) var MAX_EXPLOSIONS = 1
export (int) var EXPLOSION_RADIUS = 50
export (int) var EXPLOSION_RADIUS_GROWTH = 10
export (int) var EXPLOSION_SPACING = 20
export (Vector2) var EXPLOSION_SPACING_DIR = Vector2(0, 0)

export (int) var TRAIL_POINTS = 10
export (int) var TRAIL_SIZE = 2
export (Color) var TRAIL_COLOR

var explosions = []

onready var projectile_mover = $ProjectileMover
onready var trail = $Node/trail

var soldier_owner
var map_limit
var collision_map

func _ready():
	trail.default_color = TRAIL_COLOR
	trail.width = TRAIL_SIZE

func init(angle, charge, _soldier_owner):
	soldier_owner = _soldier_owner
	map_limit = soldier_owner.collision_map[0].size()
	projectile_mover.fire(angle, charge)

func _physics_process(delta):
	var pos = global_position
	trail.add_point(pos)
	if trail.get_point_count() > TRAIL_POINTS:
		trail.remove_point(0)

func generate_explosions():
	for i in MAX_EXPLOSIONS:
		var explosion_pos = global_position + i*EXPLOSION_SPACING*EXPLOSION_SPACING_DIR
		var explosion_radius = EXPLOSION_RADIUS + i*EXPLOSION_RADIUS_GROWTH
		explosions.append([explosion_pos, explosion_radius])

func exploded():
	generate_explosions()
	emit_signal("exploded", self)
	effect()
	soldier_owner.restore_ammo()

func effect():
	pass
