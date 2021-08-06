extends Spatial

onready var player = $Player
onready var level = $Level
onready var checkpoint_manager = $CheckpointManager

func checkpoint_reached(checkpoint):
	var current_point = checkpoint_manager.current_amount
	var new_point = checkpoint.checkpoint_id
	
	if new_point > current_point:
		checkpoint_manager.set_amount(new_point)
		level.create_checkpoint(player.get_info())

func _on_Player_died():
	print("morri")
