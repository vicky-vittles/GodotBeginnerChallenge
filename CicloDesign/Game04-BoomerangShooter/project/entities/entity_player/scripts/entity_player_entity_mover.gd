extends GTTopdownEntityMover2D

export (float) var bounce_factor = 0.8

var initial_max_move_speed : float
var speed_multiplier : float = 1.0 setget set_speed_multiplier # Speed multiplier

func _ready():
	initial_max_move_speed = max_move_speed

func _on_collision(result):
	clear_forces()
	velocity = velocity.bounce(result["normal"])*bounce_factor

func set_speed_multiplier(_value):
	speed_multiplier = _value
	max_move_speed = initial_max_move_speed * speed_multiplier
