extends Node
signal switch_weapon(weapon)

const MAX_WEAPONS = 2
const WEAPONS = {
	1: preload("res://entities/projectile/teleport_projectile.tscn"),
	2: preload("res://entities/projectile/grenade_projectile.tscn")}

var current_selection : int

func _ready():
	switch_weapon(1)

func switch_weapon(selection: int):
	if selection < 1 or selection > MAX_WEAPONS:
		return
	current_selection = selection
	emit_signal("switch_weapon", WEAPONS[selection])
