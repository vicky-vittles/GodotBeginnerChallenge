extends KinematicBody2D
class_name EntityPlayerBody

const screen_center = Vector2.ONE/2

export (NodePath) var actor_path

onready var actor = get_node(actor_path)
onready var rotation_pivot = $graphics/rotation_pivot
onready var entity_mover = $EntityMover
onready var recoil_mover = $RecoilMover

var recoil_direction : Vector2

func _on_MouseController_mouse_position(pos):
	var mouse_global_pos = actor.camera.global_position + Globals.get_screen_size()*(pos-screen_center)
	var move_direction = global_position.direction_to(mouse_global_pos)
	recoil_direction = -move_direction
	entity_mover.set_move_direction(move_direction)
	rotation_pivot.look_at(mouse_global_pos)

func _on_fire_just_pressed():
	recoil_mover.apply_force(recoil_mover.move_acceleration*recoil_direction, recoil_mover.move_deceleration_time)
