extends Node2D

signal player_fired(direction)
signal player_released()
signal boomerang_ready()
signal boomerang_flying()
signal boomerang_before_returning()
signal boomerang_returning()
signal boomerang_exited_screen()

enum BOOMERANG_MODE {
	RANDOM_RETURN_ANGLE,
	FOLLOW_PLAYER}

export (NodePath) var player_path
export (BOOMERANG_MODE) var boomerang_mode = BOOMERANG_MODE.RANDOM_RETURN_ANGLE
export (float) var min_boomerang_size = 1.0
export (float) var max_boomerang_size = 2.5
export (float) var go_flight_time = 1.0
export (float) var min_return_angle = 5.0
export (float) var max_return_angle = 15.0
export (float) var min_rotation_speed = 180.0
export (float) var max_rotation_speed = 720.0

onready var player = get_node(player_path)
onready var body = $Body
onready var offscreen_arrow = $OffscreenIndicator
onready var go_entity_mover = $Body/GoEntityMover
onready var return_entity_mover = $Body/ReturnEntityMover
onready var rotation_pivot = $Body/graphics/rotation_pivot
onready var flight_timer = $Timers/FlightTimer
onready var turnaround_timer = $Timers/TurnaroundTimer
onready var minimum_flight_timer = $Timers/MinimumFlightTimer

var move_direction : Vector2
var target_position : Vector2

func set_mouse_position(pos):
	target_position = Globals.get_screen_size()*pos

func fire(direction: Vector2):
	emit_signal("player_fired", direction)

func release():
	emit_signal("player_released")

func _on_Ready_state_entered():
	emit_signal("boomerang_ready")

func _on_Flying_state_entered():
	emit_signal("boomerang_flying")

func _on_Flying_started_returning():
	emit_signal("boomerang_returning")

func _on_Flying_exited_screen():
	emit_signal("boomerang_exited_screen")

func _on_BeforeReturningTimer_timeout():
	emit_signal("boomerang_before_returning")
