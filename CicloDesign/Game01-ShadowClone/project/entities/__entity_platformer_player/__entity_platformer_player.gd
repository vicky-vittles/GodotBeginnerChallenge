extends GTEntity2D

export (int) var max_move_speed = 256
export (float) var move_acceleration = 0.2
export (float) var move_deceleration = 0.2
export (float) var air_acceleration = 0.2
export (float) var air_deceleration = 0.2

export (int) var jump_height = 256
export (float) var jump_time = 0.5
export (int) var max_jumps = 1
export (bool) var can_jump_while_falling = true

onready var input_controller = $InputController
onready var body = $Body
onready var entity_mover = $Body/EntityMover
onready var jump_cooldown_timer = $Timers/JumpCooldownTimer
onready var coyote_timer = $Timers/CoyoteTimer

func _on_EntityMover_tree_entered():
	get_node("Body/EntityMover").MAX_MOVE_SPEED = max_move_speed
	get_node("Body/EntityMover").MOVE_ACCELERATION = move_acceleration
	get_node("Body/EntityMover").MOVE_DECELERATION = move_deceleration
	get_node("Body/EntityMover").AIR_ACCELERATION = air_acceleration
	get_node("Body/EntityMover").AIR_DECELERATION = air_deceleration
	get_node("Body/EntityMover").JUMP_SPEED = Utils.jump_speed_formula(jump_height, jump_time)
	get_node("Body/EntityMover").GRAVITY = Utils.gravity_formula(jump_height, jump_time)
	get_node("Body/EntityMover").MAX_JUMPS = max_jumps
