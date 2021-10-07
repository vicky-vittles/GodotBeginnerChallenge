extends Node2D

export (NodePath) var body_path
export (NodePath) var boomerang_path
export (bool) var is_active = true
export (Color) var line_color
export (float) var line_width = 8.0
export (float) var line_dash = 4.0

onready var body = get_node(body_path)
onready var boomerang = get_node(boomerang_path)

func _process(delta):
	if is_active:
		update()

func _draw():
	draw_dashed_line(body.global_position, boomerang.body.global_position, line_color, line_width, line_dash)

func draw_dashed_line(from, to, color, width, dash_length = 5, cap_end = false, antialiased = false):
	var length = (to - from).length()
	var normal = (to - from).normalized()
	var dash_step = normal * dash_length
	
	if length < dash_length: #not long enough to dash
		draw_line(from, to, color, width, antialiased)
		return

	else:
		var draw_flag = true
		var segment_start = from
		var steps = length/dash_length
		for start_length in range(0, steps + 1):
			var segment_end = segment_start + dash_step
			if draw_flag:
				draw_line(segment_start, segment_end, color, width, antialiased)

			segment_start = segment_end
			draw_flag = !draw_flag
		
		if cap_end:
			draw_line(segment_start, to, color, width, antialiased)
