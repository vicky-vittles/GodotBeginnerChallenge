extends Node2D

func update_bombs(current_ammo: int):
	for i in get_child_count():
		var circle = get_child(i)
		circle.visible = i < current_ammo
