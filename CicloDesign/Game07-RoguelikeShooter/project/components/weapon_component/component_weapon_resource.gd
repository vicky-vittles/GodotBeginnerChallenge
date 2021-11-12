extends Resource
class_name ComponentWeaponResource

enum WEAPONS {
	BULLET_SHOOTER}

export (WEAPONS) var weapon_type
export (PackedScene) var projectile
export (float) var cooldown_time
