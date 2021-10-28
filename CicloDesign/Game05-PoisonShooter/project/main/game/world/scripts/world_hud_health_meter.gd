extends Node2D

func update_health(current_health: int):
	var circle = get_child(current_health)
	circle.simple_scale(Vector2.ONE, Vector2.ZERO)
