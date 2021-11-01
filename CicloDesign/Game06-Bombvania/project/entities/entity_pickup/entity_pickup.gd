tool
extends GTEntity2D

signal pickup(type)

const SPRITE_FRAMES = {
	Globals.PICKUP_TYPES.PLUS_AMMO: 4,
	Globals.PICKUP_TYPES.PLUS_FIRE: 5,
	Globals.PICKUP_TYPES.REMOTE_BOMB: 6,
	Globals.PICKUP_TYPES.SPIKE_BOMB: 7}

export (Globals.PICKUP_TYPES) var pickup_type = Globals.PICKUP_TYPES.PLUS_AMMO

onready var main_sprite = $PickupTrigger/visuals/graphics/main

func _process(delta):
	main_sprite.frame = SPRITE_FRAMES[pickup_type]

func _on_PickupTrigger_effect():
	emit_signal("pickup", pickup_type)
	queue_free()
