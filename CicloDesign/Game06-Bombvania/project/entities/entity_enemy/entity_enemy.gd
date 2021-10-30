extends GTEntity2D

const ANIM_NAMES = {
	Globals.ENEMY_TYPES.BLOB: "enemy_blob",
	Globals.ENEMY_TYPES.KNIGHT: "enemy_knight"}

export (Globals.ENEMY_TYPES) var enemy_type = Globals.ENEMY_TYPES.BLOB
export (Vector2) var move_direction

onready var turnaround_timer = $Timers/TurnaroundTimer
onready var change_direction_timer = $Timers/ChangeDirectionTimer
onready var entity_mover = $Body/EntityMover
onready var body_animation_player = $Body/AnimationPlayer
onready var health = $Health

func _ready():
	var anim_name = ANIM_NAMES[enemy_type]
	body_animation_player.play(anim_name)
