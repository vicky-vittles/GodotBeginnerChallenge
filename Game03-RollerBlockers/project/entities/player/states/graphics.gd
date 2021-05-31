extends Spatial
signal finished_roll_animation()

onready var pivot_direction = $pivot_direction
onready var animation_player = $AnimationPlayer

var facing = Vector3.RIGHT
var current_orientation = "v"

func roll(dir: Vector3):
	var base_angle = Vector2(dir.x, dir.z).angle()
	pivot_direction.rotation_degrees.y = rad2deg(-base_angle)
	var anim_name = get_roll_name(dir)
	facing = dir
	animation_player.play(anim_name)

func get_roll_name(dir: Vector3):
	var dir_x = sign(dir.x) != 0
	var dir_z = sign(dir.x) == 0 and sign(dir.z) != 0
	match current_orientation:
		"v":
			current_orientation = "h"
			return "roll_vh"
		"h":
			var facing_x = sign(facing.x) != 0
			var facing_z = sign(facing.x) == 0 and sign(facing.z) != 0
			if dir_x:
				if facing_x:
					
				current_orientation = "v"
				return "roll_hv"
			else:
				current_orientation = "h"
				return "roll_hh"
		_:
			return null

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name.find("roll") != -1:
		emit_signal("finished_roll_animation")
