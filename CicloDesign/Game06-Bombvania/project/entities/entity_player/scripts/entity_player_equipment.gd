extends Node

signal gained_ammo()
signal gained_power()
signal updated_ammo(total)
signal updated_power(total)

export (int) var ammo = 1
export (int) var power = 1
export (float) var bomb_fuse_time = 2.0
export (bool) var bomb_spike = false
export (bool) var bomb_remote = false
export (bool) var bomb_kick = false

func get_bomb_info() -> Dictionary:
	return {
		"power": power,
		"fuse_time": bomb_fuse_time,
		"is_spike": bomb_spike,
		"is_remote": bomb_remote}

func gain_ammo():
	ammo += 1
	emit_signal("gained_ammo")
	emit_signal("updated_ammo", ammo)

func gain_power():
	power += 1
	emit_signal("gained_power")
	emit_signal("updated_power", power)

func _on_PickupTrigger_grouped_area_entered(area):
	match area.entity.pickup_type:
		Globals.PICKUP_TYPES.PLUS_AMMO:
			gain_ammo()
		Globals.PICKUP_TYPES.PLUS_FIRE:
			gain_power()
		Globals.PICKUP_TYPES.SPIKE_BOMB:
			bomb_spike = true
		Globals.PICKUP_TYPES.REMOTE_BOMB:
			bomb_remote = true
