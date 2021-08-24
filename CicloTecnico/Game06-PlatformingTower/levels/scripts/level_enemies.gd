extends Node2D

signal player_entered()

func _ready():
	for child in get_children():
		child.connect("player_entered", self, "_on_Enemy_player_entered")

func _on_Enemy_player_entered():
	emit_signal("player_entered")
