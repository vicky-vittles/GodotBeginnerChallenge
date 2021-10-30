extends Node2D

func has_bomb_in_pos(pos: Vector2) -> bool:
	for bomb in get_children():
		var tile_pos = Globals.world_to_tile(pos)
		var _tile_pos = Globals.world_to_tile(bomb.body.global_position)
		if tile_pos == _tile_pos:
			return true
	return false
