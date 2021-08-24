extends CanvasLayer

onready var game_over = $root/game_over/label

func game_ended(winner_id):
	if winner_id == 1:
		game_over.text = "White Ship has won!\nPress R to restart"
	elif winner_id == 2:
		game_over.text = "Black Ship has won!\nPress R to restart"
	else:
		game_over.text = "It's a draw!\nPress R to restart"
	get_node("root/AnimationPlayer").play("end_game")
