extends Node2D

onready var player = $Player
onready var camera = $Camera
onready var floor_transition_timer = $FloorTransitionTimer

var current_floor : int = 1

func _on_Tower_update_current_floor(floor_node):
	player.character_mover.freeze(not (floor_node.floor_number > current_floor))
	floor_transition_timer.start()
	camera.clear_targets()
	camera.add_target(floor_node)

func _on_FloorTransitionTimer_timeout():
	player.character_mover.unfreeze()

func _on_Tower_update_player_pos(new_pos):
	player.global_position = new_pos
