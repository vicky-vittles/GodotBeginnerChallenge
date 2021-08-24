extends Node2D
signal game_started()
signal game_ended(winner_id)

const MAX_POINTS = 1080

onready var bombs = $Bombs
onready var players = $Players

func _ready():
	start_game()

func start_game():
	emit_signal("game_started")


func _process(delta):
	var total_points_collected = players.get_player(1).points_manager.points + players.get_player(2).points_manager.points
	if total_points_collected >= MAX_POINTS:
		end_game()

func end_game():
	var p1_points = players.get_player(1).points_manager.points
	var p2_points = players.get_player(2).points_manager.points
	
	if p1_points > p2_points:
		emit_signal("game_ended", 1)
	elif p2_points > p1_points:
		emit_signal("game_ended", 2)
	else:
		emit_signal("game_ended", 0)

func _on_Block_destroyed(player_id, points):
	var player = players.get_player(player_id)
	player.plus_points(points)
