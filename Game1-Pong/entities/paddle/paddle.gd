extends KinematicBody2D

const SPEED = 500
const BALL_DIST_THRESHOLD = 24
export (int) var paddle_id = 1
export (bool) var is_human = true

var direction : Vector2
var velocity : Vector2


func _process(_delta):
	if is_human:
		input_human()
	else:
		input_ai()

func input_human():
	var move_up = "move_up_%s" % paddle_id
	var move_down = "move_down_%s" % paddle_id
	direction = Vector2.ZERO
	direction.y = int(Input.is_action_pressed(move_down)) - int(Input.is_action_pressed(move_up))

func input_ai():
	var ball_y = get_parent().ball.global_position.y
	var my_y = global_position.y
	var dir_y = ball_y-my_y
	if abs(dir_y) < BALL_DIST_THRESHOLD:
		direction = Vector2.ZERO
	else:
		direction = Vector2(0,dir_y).normalized()


func _physics_process(_delta):
	velocity = SPEED * direction
	velocity = move_and_slide(velocity)
