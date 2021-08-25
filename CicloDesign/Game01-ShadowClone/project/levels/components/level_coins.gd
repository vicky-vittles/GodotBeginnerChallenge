extends Node2D

signal coin_collected()

func _ready():
	for coin in get_children():
		coin.connect("collected", self, "emit_signal", ["coin_collected"])
