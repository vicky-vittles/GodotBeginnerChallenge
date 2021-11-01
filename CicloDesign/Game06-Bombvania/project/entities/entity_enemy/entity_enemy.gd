tool
extends GTEntity2D

const SPRITE_FRAMES = {
	Globals.ENEMY_TYPES.BLOB: 0,
	Globals.ENEMY_TYPES.KNIGHT: 1}
const ANIM_NAMES = {
	Globals.ENEMY_TYPES.BLOB: "enemy_blob",
	Globals.ENEMY_TYPES.KNIGHT: "enemy_knight"}

export (Globals.ENEMY_TYPES) var enemy_type = Globals.ENEMY_TYPES.BLOB
export (Vector2) var move_direction

onready var body = $Body
onready var turnaround_timer = $Timers/TurnaroundTimer
onready var repeat_timer = $Timers/RepeatTimer
onready var debug_sprite = $Body/visuals/debug
onready var entity_mover = $Body/EntityMover
onready var body_animation_player = $Body/AnimationPlayer
onready var health = $Health

func _ready():
	var anim_name = ANIM_NAMES[enemy_type]
	body_animation_player.play(anim_name)

func _process(delta):
	debug_sprite.frame = SPRITE_FRAMES[enemy_type]
	debug_sprite.visible = Engine.editor_hint
