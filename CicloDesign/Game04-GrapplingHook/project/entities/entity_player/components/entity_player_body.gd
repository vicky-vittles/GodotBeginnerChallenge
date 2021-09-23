extends "res://entities/__entity_platformer_player/components/entity_platformer_player_body.gd"

onready var hook_entity_mover = $HookEntityMover

func _on_Hookshot_collided(info):
	var collision_point = info["position"]
	var direction = global_position.direction_to(collision_point)
	entity_mover.disable()
	hook_entity_mover.enable()
	hook_entity_mover.velocity = hook_entity_mover.MAX_MOVE_SPEED * direction
