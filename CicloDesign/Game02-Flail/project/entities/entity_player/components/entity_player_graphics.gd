extends Node2D

export (NodePath) var actor_path
onready var actor = get_node(actor_path)

export (float) var move_trail_size_min = 8
export (float) var move_trail_size_max = 80
export (float) var color_threshold = 0.4

onready var move_trail = $move_trail
onready var sized_diamond = $sized_diamond
onready var diamond = $sized_diamond/juice_squash/juice_collision/diamond

func _on_Health_health_updated(current):
	var t = current/100.0
	sized_diamond.scale = actor.diamond_scale_min.linear_interpolate(actor.diamond_scale_max, t)
	move_trail.width = lerp(move_trail_size_min, move_trail_size_max, t)
	if t <= color_threshold:
		var k = t/color_threshold
		var color = Globals.PALETTE_COLORS[3].linear_interpolate(Globals.PALETTE_COLORS[1], k)
		diamond.polygon_color = color
		move_trail.default_color = color
	else:
		diamond.polygon_color = Globals.PALETTE_COLORS[1]
		move_trail.default_color = Globals.PALETTE_COLORS[1]
