extends Node

func get_int_pos(pos: Vector2):
	return Vector2(int(pos.x), int(pos.y))

func get_game():
	return get_node("../Game")
