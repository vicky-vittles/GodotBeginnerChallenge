extends GTEntity2D

const Z_GRAVITY : float = 0.2
const ANIM_NAMES = {
	Globals.COLLECTIBLE_TYPES.HEART: "heart",
	Globals.COLLECTIBLE_TYPES.MONEY_COIN: "money_coin",
	Globals.COLLECTIBLE_TYPES.MONEY_DIAMOND: "money_diamond"}
const SHADOW_SPRITE_INDICES = {
	Globals.COLLECTIBLE_TYPES.HEART: 0,
	Globals.COLLECTIBLE_TYPES.MONEY_COIN: 3,
	Globals.COLLECTIBLE_TYPES.MONEY_DIAMOND: 6}

onready var shadow_sprite = $Body/visuals/graphics/shadow
onready var position_pivot = $Body/visuals/graphics/position_pivot
onready var entity_mover = $Body/EntityMover
onready var body_animation_player = $Body/AnimationPlayer

var collectible_type : int = Globals.COLLECTIBLE_TYPES.MONEY_COIN
var z_pos : float
var z_speed : float
var is_initialized : bool = false

func init():
	z_pos = 32.0
	body_animation_player.play(ANIM_NAMES[collectible_type])
	match collectible_type:
		Globals.COLLECTIBLE_TYPES.MONEY_COIN, Globals.COLLECTIBLE_TYPES.MONEY_DIAMOND:
			entity_mover.velocity = Utils.rand_direction()*entity_mover.max_velocity
	is_initialized = true

func _physics_process(delta):
	if not is_initialized:
		return
	if z_pos > 0:
		z_speed -= Z_GRAVITY
	z_pos += z_speed
	if z_pos < 0:
		z_pos = -z_pos
		if z_speed < 0:
			z_speed = -z_speed*0.8
		if z_speed < 1.0:
			z_pos = 0
			z_speed = 0
	
	var frame_offset
	if z_pos < 8: frame_offset = 0
	elif z_pos < 20: frame_offset = 1
	else: frame_offset = 2
	shadow_sprite.frame = SHADOW_SPRITE_INDICES[collectible_type] + frame_offset
	position_pivot.position = Vector2(0, -z_pos)
