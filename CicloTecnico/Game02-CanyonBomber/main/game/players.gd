extends Node2D

export (int) var left_pos = -100
export (int) var right_pos = 900

func get_player(player_id):
	return get_node(str(player_id))

func _on_PlayerFlipDirection_body_entered(body):
	if body.is_in_group("player"):
		body.scale.x *= -1
		body.direction.x *= -1
		var dir = body.entity_mover.direction
		body.entity_mover.set_direction(-dir)
