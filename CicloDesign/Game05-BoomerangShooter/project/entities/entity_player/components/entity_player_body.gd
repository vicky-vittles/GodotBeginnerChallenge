extends KinematicBody2D

export (NodePath) var actor_path

onready var actor = get_node(actor_path)
onready var rotation_pivot = $graphics/rotation_pivot
onready var entity_mover = $EntityMover

func _on_MouseController_mouse_position(pos):
	var mouse_global_pos = Globals.get_screen_size()*pos
	actor.aim_direction = global_position.direction_to(mouse_global_pos)
	rotation_pivot.look_at(mouse_global_pos)
