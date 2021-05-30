extends Node
signal start_game()

onready var game = $Game
var game_started : bool = false

func _ready():
	get_tree().paused = true
	if SessionManager.replay_type_chosen == SessionManager.REPLAY_TYPE.GAME_OVER:
		get_node("Display/root/AnimationPlayer").play("title_screen")
	else:
		get_node("Display/root/title_screen").visible = false
		start_game()

func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	if Input.is_action_just_pressed("reload") and game_started:
		SessionManager.replay_type_chosen = SessionManager.REPLAY_TYPE.FORCED
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("space") and not game_started:
		start_game()

func start_game():
	get_tree().paused = false
	game_started = true
	emit_signal("start_game")

func game_ended(winner_id):
	get_tree().paused = true
	SessionManager.replay_type_chosen = SessionManager.REPLAY_TYPE.GAME_OVER
