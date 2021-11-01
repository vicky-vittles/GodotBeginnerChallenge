extends Node2D

signal switched_room(new_room)

func switched_rooms(new_room):
	emit_signal("switched_room", new_room)
