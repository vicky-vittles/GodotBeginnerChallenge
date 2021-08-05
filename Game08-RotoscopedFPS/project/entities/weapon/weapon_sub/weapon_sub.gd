extends "res://entities/weapon/__weapon.gd"

export (PackedScene) var BULLET

func fire():
	var bullet = BULLET.instance()
	Globals.get_game().add_entity(bullet)
