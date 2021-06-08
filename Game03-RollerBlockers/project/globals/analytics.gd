extends Node

#const API_URL = "http://localhost:3000/"
const API_URL = "https://player-analytics-api.herokuapp.com/"
const LIST_GAMES = "games/"
const CREATE_PLAY_SESSION = "play_sessions/create"
const CREATE_SESSION_DATA = "session_data/create"

const GAME_ID = "8721e12d-5f8b-4a4e-b9d7-8cad2d0855f6"
const DEFAULT_NAME = "default"

var debug_mode : bool = true
var sending_analytics : bool = false
var app_timer : float = 0.0
var data = {
	"total_playtime": 0 #In seconds
}


func _ready():
	get_tree().set_auto_accept_quit(false)

func _process(delta):
	if Input.is_action_just_pressed("debug_mode"):
		debug_mode = !debug_mode
		print("Debug mode now: %s" % ["on" if debug_mode else "off"])
	app_timer += delta
	set_total_playtime(int(app_timer))

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		if not debug_mode:
			if not sending_analytics:
				#print("Sending analytics...")
				sending_analytics = true
				send_data()
		else:
			get_tree().quit()


# Send data
func send_data():
	var body = {
		"data_json": data,
		"name": DEFAULT_NAME,
		"game_id": GAME_ID
	}
	var json_body = to_json(body)
	var HEADERS = ["User-Agent: godot", "Content-Type: application/json"]
	get_node("HTTP").request(API_URL+CREATE_SESSION_DATA, HEADERS, false, HTTPClient.METHOD_POST, json_body)

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var result_json = JSON.parse(body.get_string_from_utf8()).result
		var result_data = result_json["data"]
		
		#print("HTTP Connection success\n")
		#print(result_json)
	else:
		#print("HTTP Connection error %s \n" % response_code)
		pass
	get_tree().quit()


# Set data
func set_total_playtime(value: int):
	data["total_playtime"] = value

func set_level_playtime(level_id: int, value: int):
	data["level_playtimes"][level_id] = value

func set_total_deaths(value: int):
	data["total_deaths"] = value

func set_level_deaths(level_id: int, value: int):
	data["level_deaths"][level_id] = value
