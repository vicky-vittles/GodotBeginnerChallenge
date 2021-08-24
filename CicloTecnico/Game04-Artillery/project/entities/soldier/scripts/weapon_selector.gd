extends Node
signal switch_weapon(weapon)

const MAX_WEAPONS = 1
const WEAPON_GRENADE = 1
const WEAPON_TELEPORTER = 2
const WEAPON_DIGGER = 3
const WEAPONS = {
	WEAPON_GRENADE: preload("res://entities/projectile/grenade_projectile.tscn")}

var current_selection : int
var prototype

func _ready():
	switch_weapon(1)

func switch_weapon(selection: int):
	if selection < 1 or selection > MAX_WEAPONS or selection == current_selection:
		return
	current_selection = selection
	prototype = get_weapon().instance()
	emit_signal("switch_weapon", get_weapon())

func get_weapon():
	return WEAPONS[current_selection]
