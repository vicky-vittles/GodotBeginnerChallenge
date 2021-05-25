extends Node

func get_pos(tile_id: int, tiles: Array) -> int:
	for i in tiles.size():
		if tiles[i] == tile_id:
			return i
	return -1

func id_to_pos(tile_id: int, BOARD_SIZE: Vector2) -> Vector2:
	return Vector2(
		tile_id % int(BOARD_SIZE.x),
		int(tile_id / int(BOARD_SIZE.y)))

func pos_to_id(tile_pos: Vector2, BOARD_SIZE: Vector2) -> int:
	return int(tile_pos.y)*int(BOARD_SIZE.y) + int(tile_pos.x)

func is_valid_pos(pos: Vector2, BOARD_SIZE: Vector2) -> bool:
	var lower_ok = pos.x >= 0 and pos.y >= 0
	var higher_ok = pos.x < BOARD_SIZE.x and pos.y < BOARD_SIZE.y
	return lower_ok and higher_ok
