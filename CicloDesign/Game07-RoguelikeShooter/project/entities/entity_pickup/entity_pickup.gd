extends Entity2D

var ANIM_NAMES = {
	Globals.PICKUP_TYPES.PLUS_PLAYER_STRENGTH: "plus_player_strength",
	Globals.PICKUP_TYPES.PLUS_PLAYER_SPEED: "plus_player_speed",
	Globals.PICKUP_TYPES.PLUS_PLAYER_HEALTH: "plus_player_health",
	Globals.PICKUP_TYPES.PLUS_WEAPON_BULLETS: "plus_weapon_bullets",
	Globals.PICKUP_TYPES.PLUS_WEAPON_BULLET_SPEED: "plus_weapon_bullet_speed",
	Globals.PICKUP_TYPES.PLUS_WEAPON_BULLET_SIZE: "plus_weapon_bullet_size",
	Globals.PICKUP_TYPES.PLUS_WEAPON_BULLET_FIRE_SPEED: "plus_weapon_bullet_fire_speed"}

export (Globals.PICKUP_TYPES) var pickup_type

onready var pickup_type_animation_player = $PickupType

func _ready():
	initialize()

func initialize():
	pickup_type_animation_player.play(ANIM_NAMES[pickup_type])

func set_pickup_type(_type):
	pickup_type = _type
	initialize()
