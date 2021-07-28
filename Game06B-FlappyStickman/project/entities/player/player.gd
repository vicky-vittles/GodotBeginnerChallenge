extends KinematicBody2D

signal gained_point()
signal die()

onready var input_controller = $InputController
onready var character_mover = $CharacterMover
onready var ground_raycast = $Areas/GroundRaycast
onready var jump_cooldown = $JumpCooldown
onready var damage_hurtbox = $Areas/DamageHurtbox
onready var graphics = $Graphics

export (int) var max_jumps = 2
onready var available_jumps : int = max_jumps

func can_jump() -> bool:
	return (available_jumps > 0 and jump_cooldown.is_stopped())

func decrease_jump():
	available_jumps = clamp(available_jumps - 1, 0, max_jumps)

func restore_jumps():
	available_jumps = max_jumps

func die():
	emit_signal("die")
