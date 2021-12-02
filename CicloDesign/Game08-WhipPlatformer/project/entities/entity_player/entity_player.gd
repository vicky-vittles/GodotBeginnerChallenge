extends Entity2D

export (int) var walk_move_speed = 120
export (int) var crouch_move_speed = 70

onready var input_controller = $InputController
onready var health = $Stats/Health
onready var attack_timer = $Timers/AttackTimer
onready var invincibility_timer = $Timers/InvincibilityTimer
onready var body = $Body
onready var graphics = $Body/graphics
onready var graphics_animation_player = $Body/graphics/AnimationPlayer
onready var whip_sprite = $Body/graphics/visuals/whip
onready var entity_mover = $Body/EntityMover
onready var impulse_entity_mover = $Body/ImpulseEntityMover
onready var triggers = $Body/Triggers
onready var hurtbox = $Body/Triggers/Hurtbox
onready var head_raycasts = $Body/Triggers/head_raycasts
onready var whip_head_trigger = $Body/Triggers/whip_head_trigger
onready var animation_player = $AnimationPlayer

var previous_move_direction : int = 1
var aim_direction : Vector2 = Vector2.RIGHT

func orient(dir):
	if dir != 0:
		previous_move_direction = dir
	graphics.scale.x = previous_move_direction
	triggers.scale.x = previous_move_direction

func _on_AimDirectionController_updated_air_direction(direction):
	aim_direction = direction
