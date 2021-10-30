extends GTEntity2D

signal pickup(type)

const ANIM_NAMES = {
	Globals.PICKUP_TYPES.PLUS_AMMO: "plus_ammo",
	Globals.PICKUP_TYPES.PLUS_FIRE: "plus_fire",
	Globals.PICKUP_TYPES.SPIKE_BOMB: "spike_bomb",
	Globals.PICKUP_TYPES.REMOTE_BOMB: "remote_bomb"}

export (Globals.PICKUP_TYPES) var pickup_type = Globals.PICKUP_TYPES.PLUS_AMMO

onready var trigger_animation_player = $PickupTrigger/AnimationPlayer

func _ready():
	trigger_animation_player.play(ANIM_NAMES[pickup_type])

func _on_PickupTrigger_effect():
	emit_signal("pickup", pickup_type)
	queue_free()
