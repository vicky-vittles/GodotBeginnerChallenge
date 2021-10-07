extends KinematicBody2D

export (NodePath) var actor_path

onready var actor = get_node(actor_path)
onready var rotation_pivot = $graphics/rotation_pivot
onready var entity_mover = $EntityMover
onready var catch_trigger = $Triggers/CatchTrigger

func _ready():
	if actor.catch_mode == actor.CATCH_MODE.DEFAULT:
		catch_trigger.disable_all_shapes()

func _on_MouseController_mouse_position(pos):
	var mouse_global_pos = Globals.get_screen_size()*pos
	actor.aim_direction = global_position.direction_to(mouse_global_pos)
	rotation_pivot.look_at(mouse_global_pos)

func _on_fire_just_pressed():
	if actor.catch_mode == actor.CATCH_MODE.DEFAULT:
		catch_trigger.enable_all_shapes()

func _on_CatchTimer_timeout():
	if actor.catch_mode == actor.CATCH_MODE.DEFAULT:
		catch_trigger.disable_all_shapes()
