extends GTEntityMover2D
class_name GTTopdownEntityMover2D

export (float) var move_acceleration_time = 0.1
export (float) var move_deceleration_time = 0.1

onready var move_acceleration = max_velocity / move_acceleration_time
onready var move_deceleration = max_velocity / move_deceleration_time

var move_timer : Timer
var move_direction : Vector2

func _ready():
	move_timer = Timer.new()
	move_timer.one_shot = true
	move_timer.name = "_MoveTimer"
	move_timer.connect("timeout", self, "set_move_direction", [Vector2.ZERO])
	add_child(move_timer)

func _physics_process(delta):
	if frozen or not is_enabled:
		return
	
	# Movement
	if move_direction == Vector2.ZERO and velocity.length() > LENGTH_THRESHOLD:
		apply_force(-velocity.normalized() * move_deceleration)
	else:
		apply_force(move_direction * move_acceleration)
	velocity = velocity.clamped(max_velocity)
	if velocity.length() < LENGTH_THRESHOLD:
		velocity = Vector2.ZERO
	._physics_process(delta)
	
	if debug_mode:
		print("move_direction: %s" % [move_direction])
		print("velocity: %s" % [velocity])
		print("\n")

func set_move_direction(_dir: Vector2, duration: float = 0.0) -> void:
	move_direction = _dir
	if duration > 0.0:
		move_timer.wait_time = duration
		move_timer.start()
