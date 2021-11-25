extends Entity2D

onready var input_controller = $InputController
onready var attack_timer = $Timers/AttackTimer
onready var body = $Body
onready var graphics = $Body/graphics
onready var whip_sprite = $Body/graphics/visuals/whip
onready var visuals_animation_player = $Body/graphics/visuals/AnimationPlayer
onready var entity_mover = $Body/EntityMover
onready var head_raycasts = $Body/Triggers/head_raycasts
onready var animation_player = $AnimationPlayer

var previous_move_direction : int = 1
var aim_direction : Vector2 = Vector2.RIGHT

func _on_InputController_updated_move_direction(direction):
	if direction != 0:
		previous_move_direction = direction
	graphics.scale.x = previous_move_direction

func _on_AimDirectionController_updated_air_direction(direction):
	aim_direction = direction
