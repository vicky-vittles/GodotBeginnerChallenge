extends Node2D

const BALL_INITIAL_POS = Vector2(400,300)

onready var ball = $Ball
onready var p1_points_label = $HUD/root/points1
onready var p2_points_label = $HUD/root/points2
onready var win_label = $HUD/root/win_label

var p1_points : int = 0
var p2_points : int = 0

func _ready():
	start_game()


func start_game():
	randomize()
	ball.set_direction(Vector2(get_rand_dir(), get_rand_dir()))

func get_rand_dir():
	return pow(-1, randi()%2)


func goal_made(paddle_id):
	ball.global_position = BALL_INITIAL_POS
	if paddle_id == 1:
		p1_points += 1
		ball.set_direction(Vector2(1, get_rand_dir()))
	elif paddle_id == 2:
		p2_points += 1
		ball.set_direction(Vector2(-1, get_rand_dir()))
	p1_points_label.text = str(p1_points)
	p2_points_label.text = str(p2_points)
	
	if p1_points > 10:
		win_label.visible = true
		win_label.text = win_label.text % "1"
		ball.position = BALL_INITIAL_POS * 10
	elif p2_points > 10:
		win_label.visible = true
		win_label.text = win_label.text % "2"
		ball.position = BALL_INITIAL_POS * 10
