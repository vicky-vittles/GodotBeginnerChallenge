extends Position2D

signal restore_ammo()

const BOMB = preload("res://entities/bomb/bomb.tscn")

func spawn_bomb(id, dir):
	var bomb = BOMB.instance()
	Globals.get_game().add_child(bomb)
	bomb.connect("restore_ammo", self, "_on_Bomb_destroyed")
	
	bomb.global_position = global_position
	bomb.spawn(id, dir)

func _on_Bomb_destroyed():
	emit_signal("restore_ammo")
