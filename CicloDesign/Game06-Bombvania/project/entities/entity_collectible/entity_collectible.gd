extends GTEntity2D

const ANIM_NAMES = {
	Globals.COLLECTIBLE_TYPES.HEART: "heart",
	Globals.COLLECTIBLE_TYPES.MONEY_COIN: "money_coin",
	Globals.COLLECTIBLE_TYPES.MONEY_DIAMOND: "money_diamond"}

onready var entity_mover = $Body/EntityMover
onready var body_animation_player = $Body/AnimationPlayer

var collectible_type : int

func init():
	body_animation_player.play(ANIM_NAMES[collectible_type])
	match collectible_type:
		Globals.COLLECTIBLE_TYPES.MONEY_COIN, Globals.COLLECTIBLE_TYPES.MONEY_DIAMOND:
			entity_mover.velocity = Utils.rand_direction()*entity_mover.max_velocity
