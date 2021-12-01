extends Entity2D

onready var body = $Body
onready var graphics = $Body/graphics
onready var triggers = $Body/Triggers
onready var raycasts = $Body/Raycasts
onready var entity_mover = $Body/EntityMover
onready var animation_player = $AnimationPlayer

var previous_move_direction : int = 1

func orient(dir):
	if dir != 0:
		previous_move_direction = dir
	graphics.scale.x = previous_move_direction
	triggers.scale.x = previous_move_direction
