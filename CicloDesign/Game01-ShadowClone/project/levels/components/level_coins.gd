extends Node2D

signal coin_collected()

func _ready():
	for coin_group in get_children():
		if "entity_type" in coin_group and coin_group.entity_type == Globals.ENTITY_TYPES.COIN:
			coin_group.connect("collected", self, "emit_signal", ["coin_collected"])
		
		if coin_group.get_child_count() > 0:
			for coin in coin_group.get_children():
				if "entity_type" in coin and coin.entity_type == Globals.ENTITY_TYPES.COIN:
					coin.connect("collected", self, "emit_signal", ["coin_collected"])
