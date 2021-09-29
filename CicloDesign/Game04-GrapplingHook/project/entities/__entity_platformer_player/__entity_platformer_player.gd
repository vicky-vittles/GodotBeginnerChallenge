extends GTEntity2D

export (bool) var can_jump_while_falling = true
export (bool) var can_small_jump = true

onready var input_controller = $InputController
onready var body = $Body
onready var entity_mover = $Body/EntityMover
onready var jump_cooldown_timer = $Timers/JumpCooldownTimer
onready var coyote_timer = $Timers/CoyoteTimer
